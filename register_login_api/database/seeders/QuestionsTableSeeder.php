<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Question;

class QuestionsTableSeeder extends Seeder
{
    public function run()
    {
        // Assuming you have quiz_id 1 for Quiz 1 from previous seeder
    
        Question::create([
            'quiz_id' => 2,
            'question_text' => 'What does "ar" mean',
            'correct_answer' => '2',
            'choices' => json_encode(['1', '2', '3', '4']),
        ]);
        Question::create([
            'quiz_id' => 2,
            'question_text' => 'What does "sim" mean',
            'correct_answer' => 'bird',
            'choices' => json_encode(['bird', 'squirrel', 'mice', 'butterfly']),
        ]);

        // Add more questions as needed
    }
}
