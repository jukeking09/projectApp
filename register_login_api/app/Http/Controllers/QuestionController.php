<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Question;
use Illuminate\Http\Request;

class QuestionController extends Controller
{
    /**
     * Display the specified question.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        // Fetch question with choices
        $questions = Question::where('quiz_id', $id)->get();

        // Iterate through each question and decode the choices JSON
        // $questions->transform(function ($question) {
        //     $question->choices = json_decode($question->choices);
        //     return $question;
        // });
    
        return response()->json(['questions' => $questions]);
    }
    
}
