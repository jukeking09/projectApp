<?php

namespace App\Http\Controllers;

use App\Models\Quiz;
use Illuminate\Http\Request;

class QuizController extends Controller
{
    public function index()
    {
        $quizzes = Quiz::all();
        return response()->json([
            'title' => $quizzes->title,
            'description' => $quizzes->description,
        ]);
    }
}
