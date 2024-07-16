<?php

// app/Http/Controllers/QuizController.php

namespace App\Http\Controllers;

use App\Models\Quiz;
use App\Models\Question;
use App\Models\QuizScore;
use App\Models\UserQuiz;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Exception;

class QuizController extends Controller
{
    public function store(Request $request)
    {
        try{
        $validatedData = $request->validate([
            'lesson_id' => 'required|exists:lessons,id',
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'questions' => 'required|array',
            'questions.*.question' => 'required|string',
            'questions.*.choices' => 'required|array|min:2',
            'questions.*.choices.*' => 'required|string',
            'questions.*.correct_answer' => 'required|string',
        ]);
        
        Log::info('Received request to add quiz: ' . json_encode($request->all()));
        $quiz = Quiz::create([
            'lesson_id' => $validatedData['lesson_id'],
            'title' => $validatedData['title'],
            'description' => $validatedData['description'],
        ]);

        foreach ($validatedData['questions'] as $questionData) {
            Question::create([
                'quiz_id' => $quiz->id,
                'question_text' => $questionData['question'],
                'choices' => $questionData['choices'],
                'correct_answer' => $questionData['correct_answer'],
            ]);
        }

        return response()->json(['success' => true, 'quiz' => $quiz ,'status' => 200 ], 200);
        }
        catch(\Exception $e){
            Log::error('Exception when adding quiz: ' . $e->getMessage());
        }
    }
    // public function getQuizByLessonId($lessonId)
    // {
    //     try {
    //         $quiz = Quiz::where('lesson_id', $lessonId)
    //                     ->with('questions')
    //                     ->first();

    //         if ($quiz) {
    //             // Manually structure the questions and their choices
    //             $quizData = $quiz->toArray();
    //             foreach ($quizData['questions'] as &$question) {
    //                 $question['choices'] = json_decode($question['choices'], true);
    //             }

    //             return response()->json(['quiz' => $quizData], 200);
    //         } else {
    //             return response()->json(['error' => 'Quiz not found'], 404);
    //         }
    //     } catch (\Exception $e) {
    //         return response()->json(['error' => 'An error occurred'], 500);
    //     }
    // }
    public function getQuizByLessonId($lessonId)
{
    try {
        $quiz = Quiz::where('lesson_id', $lessonId)
                    ->with('questions')
                    ->first();

        if ($quiz) {
            // Manually structure the questions and their choices
            $quizData = $quiz->toArray();
            foreach ($quizData['questions'] as &$question) {
                // Ensure choices is decoded only if it's a JSON string
                $question['choices'] = is_string($question['choices']) ? json_decode($question['choices'], true) : $question['choices'];
            }

            return response()->json(['quiz' => $quizData], 200);
        } else {
            return response()->json(['error' => 'Quiz not found'], 404);
        }
    } catch (\Exception $e) {
        return response()->json(['error' => 'An error occurred'], 500);
    }
}


    

    public function show(Quiz $quiz)
    {
        // Show a specific quiz
        return response()->json(['quiz' => $quiz]);
    }
    public function submitScore(Request $request)
    {
        $validatedData = $request->validate([
            'userId' => 'required|exists:users,id',
            'quizId' => 'required|exists:quizzes,id',
            'score' => 'required|integer|min:0',
        ]);

        try {
            $quizScore = QuizScore::updateOrCreate(
                ['user_id' => $validatedData['userId'], 'quiz_id' => $validatedData['quizId']],
                ['score' => $validatedData['score']]
            );

            return response()->json([
                'message' => 'Quiz score saved successfully',
                'quizScore' => $quizScore
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error saving quiz score',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    public function completeQuiz(Request $request)
{
    $validatedData = $request->validate([
        'userId' => 'required|exists:users,id',
        'quizId' => 'required|exists:quizzes,id',
    ]);
    try {
        
        // Extract user ID and quiz ID

        // Mark the quiz as completed
        $userQuiz = UserQuiz::updateOrCreate(
            ['user_id' => $validatedData['userId'], 'quiz_id' => $validatedData['quizId']],
            ['is_completed' => true]
        );

        // Fetch the lesson associated with the quiz
        $quiz = Quiz::findOrFail($validatedData['quizId']);
        $lessonId = $quiz->lesson_id;

        // Check and mark the lesson as completed if all quizzes are completed
        $lessonController = new LessonController();
        $lessonController->checkAndMarkLessonCompletion($validatedData['userId'], $lessonId);

        // Success response with updated UserQuiz object (optional)
        return response()->json([
            'message' => 'Quiz completed and lesson status updated.',
            'data' => $userQuiz, // Include updated UserQuiz object if needed
        ], 200); // Status code 200 for successful completion

    } catch (Exception $e) {
        // Log the error for debugging
        // Log::error("Error completing quiz: " . $e->getMessage());

        // Handle specific exceptions
        
            // Generic error message for other exceptions
            return response()->json(['error' => 'Failed to complete quiz'.$e->getMessage()], 500);
        }
}
}


