<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserDetailsController;
use App\Http\Controllers\LessonController;

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

//Routes For User Authentication

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

//Routes For Lesson Details
Route::get('/lessons/{id}', [LessonController::class, 'getLessonDetails']);

//Routes For GET Testings

Route::get('/hello', function () {
    return 'Hello There!';
});
