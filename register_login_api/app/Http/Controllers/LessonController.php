<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Lesson;

class LessonController extends Controller
{
    // Other controller methods...

    // Return lesson details by ID
    public function getLessonDetails($courseId)
    {
        $lesson = Lesson::findOrFail($courseId);
        
        return response()->json([
            'title' => $lesson->title,
            'content' => $lesson->content,
        ]);
    }
}
