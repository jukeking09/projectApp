<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Models\Lesson;
use App\Models\Audio;
use App\Models\UserLesson;
use App\Models\UserQuiz;
use App\Models\Quiz;

class LessonController extends Controller
{
    public function store(Request $request)
    {
        $validated = $request->validate([
            'language_id' => 'required|integer',
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'content' => 'required|string',
        ]);

        $lesson = Lesson::create([
            'language_id' => $validated['language_id'],
            'title' => $validated['title'],
            'description' => $validated['description'],
            'content' => $validated['content'],
        ]);

        return response()->json([
            'status' => 200,
            'message' => 'Lesson added successfully',
            'lesson' => $lesson,
        ]);
    }

    // Return lesson details by ID
    public function getLessonDetails($courseId)
    {
        $lesson = Lesson::findOrFail($courseId);
        
        return response()->json([
            'title' => $lesson->title,
            'content' => $lesson->content,
        ]);
    }
    public function getLessonWithAudioUrls($lessonId)
    {
        // Retrieve lesson by ID
        $lesson = Lesson::findOrFail($lessonId);

        // Initialize array to store results
        $lessonWithAudioUrls = [
            'title' => $lesson->title,
            'content' => $lesson->content,
            'audios' => [],
        ];

        // Fetch audios related to this lesson
        $audios = Audio::where('lesson_id', $lessonId)->get();

        // Store audio URLs associated with this lesson
        foreach ($audios as $audio) {
            $lessonWithAudioUrls['audios'][] = [
                'word' => $audio->word,
                'audio_url' => $audio->audio_url,
            ];
        }

        return response()->json($lessonWithAudioUrls);
    }
    public function checkAndMarkLessonCompletion($userId, $lessonId)
    {
        // Fetch all quizzes for the lesson
        $lesson = Lesson::with('quizzes')->findOrFail($lessonId);
        $quizzes = $lesson->quizzes;

        // Check if the user has completed all quizzes
        $allQuizzesCompleted = $quizzes->every(function ($quiz) use ($userId) {
            return UserQuiz::where('user_id', $userId)
                           ->where('quiz_id', $quiz->id)
                           ->where('is_completed', true)
                           ->exists();
        });

        // If all quizzes are completed, mark the lesson as completed
        if ($allQuizzesCompleted) {
            UserLesson::updateOrCreate(
                ['user_id' => $userId, 'lesson_id' => $lessonId],
                ['is_completed' => true]
            );
        }
    }
    // public function getLessonsWithCompletionStatus(Request $request, $languageId)
    // {
    //     $userId = $request->user_id;
    //     $lessons = Lesson::where('language_id', $languageId)->with('quizzes')->get();

    //     $lessonsWithCompletion = $lessons->map(function ($lesson) use ($userId) {
    //         $isCompleted = UserLesson::where('user_id', $userId)
    //                                  ->where('lesson_id', $lesson->id)
    //                                  ->exists();
    //         return [
    //             'id' => $lesson->id,
    //             'title' => $lesson->title,
    //             'description' => $lesson->description,
    //             'is_completed' => $isCompleted,
    //             'quizzes' => $lesson->quizzes->map(function ($quiz) use ($userId) {
    //                 $isCompleted = UserQuiz::where('user_id', $userId)
    //                                        ->where('quiz_id', $quiz->id)
    //                                        ->where('is_completed', true)
    //                                        ->exists();
    //                 return [
    //                     'id' => $quiz->id,
    //                     'is_completed' => $isCompleted,
    //                 ];
    //             }),
    //         ];
    //     });

    //     return response()->json($lessonsWithCompletion);
    // }



    public function getLessonsWithCompletionStatus(Request $request)
    {
        $languageId = $request->query('languageId');
        $userId = $request->query('userId');

        if (!$languageId || !$userId) {
            return response()->json(['error' => 'Missing parameters'], 400);
        }

        try {
            $lessons = Lesson::where('language_id', $languageId)->get();

            $lessonsWithCompletionStatus = $lessons->map(function ($lesson) use ($userId) {
                $isCompleted = UserLesson::where('lesson_id', $lesson->id)
                                         ->where('user_id', $userId)
                                         ->exists();
                return [
                    'id' => $lesson->id,
                    'title' => $lesson->title,
                    'description' => $lesson->description,
                    'isCompleted' => $isCompleted,
                ];
            });

            return response()->json($lessonsWithCompletionStatus);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to fetch lessons'], 500);
        }
    }
    public function getQuizzesByLessonId($lessonId)
    {
        $quizzes = Quiz::where('lesson_id', $lessonId)->with('questions')->get();
        return response()->json($quizzes);
    }
    public function getLessonAudioUrls($lessonId)
{
    // Fetch audios related to this lesson
    $audios = Audio::where('lesson_id', $lessonId)->get();

    // Store audio URLs associated with this lesson
    $audioUrls = [];
    foreach ($audios as $audio) {
        $audioUrls[] = [
            'word' => $audio->word,
            'audio_url' => $audio->audio_url,
        ];
    }

    return response()->json($audioUrls);
}
}




