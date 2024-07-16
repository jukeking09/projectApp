<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Quiz extends Model
{
    protected $fillable = ['lesson_id', 'title', 'description'];

    protected $casts = [
        'choices' => 'json', // Cast 'choices' to JSON (assuming stored as JSON)
    ];
    public function lesson()
    {
        return $this->belongsTo(Lesson::class);
    }

    public function questions()
    {
        return $this->hasMany(Question::class);
    }

    public function quizScores()
    {
        return $this->hasMany(QuizScore::class);
    }   
}
