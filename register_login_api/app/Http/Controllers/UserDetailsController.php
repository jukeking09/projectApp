<?php

namespace App\Http\Controllers;
use App\Models\User; 
use App\Models\Language;
use App\Models\UserLanguage;
use App\Models\UserLesson;
use App\Models\QuizScore;   
use Illuminate\Http\Request;
use App\Http\Resources\UserResource;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\facades\Validator;
class UserDetailsController extends Controller
{
    /**
     * Get user details by user ID.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getUserDetails($userId)
    {
        try {
            // Retrieve user details from the database
            $user = User::findOrFail($userId);

            // Return user details as JSON response
            return response()->json([
                'success' => true,
                'email' => $user->email,
            ], 200);
        } catch (\Exception $e) {
            // Return error response if user is not found or any other error occurs
            return response()->json([
                'success' => false,
                'message' => 'Failed to load user details.',
            ],400);
        }
    }
    public function getUsers()
    {
        $users = User::all();
        return response()->json($users);
    }

    public function deleteUser($id)
    {
        $user = User::findOrFail($id);
        $user->delete();
        return response()->json(['message' => 'User deleted successfully.']);
    }
    public function getLanguagesByUserId($userId)
    {
        // Ensure the user exists
        $user = User::find($userId);
        if (!$user) {
            return response()->json(['error' => 'User not found'], 404);
        }

        // Fetch the languages associated with the user
        $userLanguages = UserLanguage::where('user_id', $userId)->get();
        $languageIds = $userLanguages->pluck('language_id');
        $languages = Language::whereIn('id', $languageIds)->get();

        return response()->json($languages);
    }
    public function fetchLessonDetails($userId, Request $request )
{
    $validator = Validator::make($request->query(), [
        'language_id' => 'required|integer',
    ]);

    if ($validator->fails()) {
        return response()->json($validator->errors(), 422);
    }

    $languageId = $request->query('language_id');
    // Use $userId and $languageId to fetch lesson details
    // Example query logic:
    $lessons = DB::table('user_lessons')
        ->join('lessons', 'user_lessons.lesson_id', '=', 'lessons.id')
        ->where('user_lessons.user_id', $userId)
        ->where('lessons.language_id', $languageId)
        ->select('lessons.id as lesson_id', 'lessons.title as lesson_title', 'user_lessons.is_completed')
        ->get();

    return response()->json($lessons);
}


    public function fetchQuizScores($userId)
    {
        $quizScores = DB::table('quiz_scores')
            ->where('user_id', $userId)
            ->select('quiz_id', 'score')
            ->get();

        return response()->json($quizScores);
    }

}
