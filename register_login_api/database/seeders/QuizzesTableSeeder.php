<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Quiz;

class QuizzesTableSeeder extends Seeder
{
    public function run()
    {
        Quiz::create([
            'lesson_id' => 2,
            'title' => 'Quiz 2',
            'description' => 'Description of Quiz 2',
        ]);
        Quiz::create([
            'lesson_id' => 2,
            'title' => 'Quiz 3',
            'description' => 'Description of Quiz 3',
        ]);

        // Add more quizzes as needed
    }
}
