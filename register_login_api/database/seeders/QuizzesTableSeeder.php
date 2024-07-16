<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Quiz;

class QuizzesTableSeeder extends Seeder
{
    public function run()
    {
        Quiz::create([
            'lesson_id' => 3,
            'title' => 'Quiz 3',
            'description' => 'Basic Greetings',
        ]);
        Quiz::create([
            'lesson_id' => 3,
            'title' => 'Quiz 4',
            'description' => 'More Basic Greetings',
        ]);

        // Add more quizzes as needed
    }
}
