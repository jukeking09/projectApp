<?php

// app/Http/Controllers/QuizController.php

namespace App\Http\Controllers;

use App\Models\Quiz;
use Illuminate\Http\Request;

class QuizController extends Controller
{
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
                    $question['choices'] = json_decode($question['choices'], true);
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

}
