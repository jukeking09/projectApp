<?php

// Lesson.php (app\Models\Lesson.php)

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lesson extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'content',
        'description',
        'language_id',
    ];

    public function language()
    {
        return $this->belongsTo(Language::class);
    }

    public function quizzes()
    {
        return $this->hasMany(Quiz::class);
    }
    public function audios()
    {
        return $this->hasMany(Audio::class);
    }
    public function quizScores()
    {
        return $this->hasMany(QuizScore::class);
    }
}
