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
            'quiz_id' => 4,
            'question_text' => 'What does "Suki" mean',
            'correct_answer' => 'Slow',
            'choices' => json_encode(['Fast', 'Slow', 'Go', 'Yes']),
        ]);
        Question::create([
            'quiz_id' => 4,
            'question_text' => 'What does "Hooid" mean',
            'correct_answer' => 'Yes',
            'choices' => json_encode(['Yes', 'Understand', 'No', 'Thanks']),
        ]);
        Question::create([
            'quiz_id' => 4,
            'question_text' => 'How to address a Mr Kane',
            'correct_answer' => 'Bah Jane',
            'choices' => json_encode(['Bah Kane', 'Kumno Kane', 'Kong Kane', 'Khublei Kane']),
        ]);

        // Add more questions as needed
    }
}
