<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Audio extends Model
{
    use HasFactory;
    protected $table = 'audios';

    protected $fillable = [
        'lesson_id',
        'word',
        'audio_url',
    ];

    public function lesson()
    {
        return $this->belongsTo(Lesson::class);
    }
}
