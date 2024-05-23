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
}
