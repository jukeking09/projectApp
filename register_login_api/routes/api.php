<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserDetailsController;
use App\Http\Controllers\LessonController;
use App\Http\Controllers\LanguageController;
use App\Http\Controllers\QuizController;
use App\Http\Controllers\QuestionController;
use App\Http\Controllers\LeaderboardController;
use App\Http\Controllers\AlphabetController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and assigned to the "api" middleware group.
| Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
//Route For User Details
Route::get('/details/{id}', [UserDetailsController::class, 'getUserDetails']);
Route::get('/admin/users', [UserDetailsController::class, 'getUsers']);
Route::delete('/admin/users/{id}', [UserDetailsController::class, 'deleteUser']);
Route::get('users/{userId}/languages', [UserDetailsController::class, 'getLanguagesByUserId']);
Route::get('/user/{userId}/lessons', [UserDetailsController::class, 'fetchLessonDetails']);
Route::get('/user/{userId}/quiz-scores', [UserDetailsController::class, 'fetchQuizScores']);
//Routes For User Authentication

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

//Routes for LangaugeController

Route::post('/addLanguage', [LanguageController::class, 'store']);
Route::get('/language', [LanguageController::class, 'getAvailableLanguages']);
Route::post('/savelanguage', [LanguageController::class,'saveUserLanguage']);
Route::get('/getlessonsbylanguage/{language_id}', [LanguageController::class, 'getLessonsByLanguage']);


//Routes For Lesson Details


// Route for fetching lessons with completion status
// Route::get('/lessonswithcompletion/{languageId}', [LessonController::class, 'getLessonsWithCompletionStatus']);
Route::get('lessons/{lessonId}/audios', [LessonController::class, 'getLessonAudioUrls']);
Route::get('lessons/{lessonId}/quizzes', [LessonController::class, 'getQuizzesByLessonId']);
Route::get('/lessons', [LessonController::class, 'getLessonsWithCompletionStatus']);
Route::get('/lessonswithaudio/{lessonId}', [LessonController::class, 'getLessonWithAudioUrls']);
Route::get('/lessons/{id}', [LessonController::class, 'getLessonDetails']);
Route::post('/addLesson', [LessonController::class, 'store']);

// Quizzes routes
Route::post('/addQuiz', [QuizController::class, 'store']);
Route::post('/quizzes/submitScore', [QuizController::class,'submitScore']);
Route::get('/quizzes/{lesson_id}', [QuizController::class, 'getQuizByLessonId']);
Route::get('/quizzes/{quiz_id}', [QuizController::class, 'show']);
// Route for completing a quiz
Route::post('quizzes/markCompleted', [QuizController::class, 'completeQuiz']);
//Alphabets routes

Route::get('/alphabets/{languageId}', [AlphabetController::class, 'getAlphabets']);


// Questions routes
Route::get('/questions/{id}', [QuestionController::class, 'show']);

//Route for leaderboard

Route::get('leaderboard', [LeaderboardController::class, 'index']);

//Routes For GET Testings

Route::get('/hello', function () {
    return 'Hello There!';
});
