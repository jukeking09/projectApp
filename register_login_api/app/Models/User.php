<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];
    public function languages()
    {
        return $this->belongsToMany(Language::class, 'user_languages', 'user_id', 'language_id');
    }
    public function quizScores()
    {
        return $this->hasMany(QuizScore::class);
    }

    public function getUserProgress($userId)
{
    $lessons = Lesson::with(['quizzes' => function ($query) use ($userId) {
        $query->whereHas('userQuizzes', function ($query) use ($userId) {
            $query->where('user_id', $userId)->where('is_completed', true);
        });
    }])->get();

    return response()->json($lessons);
}
}
