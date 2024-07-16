<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    protected $fillable = ['quiz_id', 'question_text', 'correct_answer', 'choices'];
    protected $casts = [
        'choices' => 'array', // Cast 'choices' to array
    ];
    public function quiz()
    {
        return $this->belongsTo(Quiz::class);
    }
}
