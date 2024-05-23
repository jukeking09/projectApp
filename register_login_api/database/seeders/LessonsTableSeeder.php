<?php
namespace Illuminate\Database\Seeders;

use Illuminate\Database\Seeder;
use App\Lesson;


class LessonsTableSeeder extends Seeder
{
    public function run()
    {
        Lesson::create([
            'id' => 1,
            'title' => 'First Lesson',
            'content' => 'Khasi (Ka Ktien Khasi) is an Austroasiatic 
            language with just over a million speakers in north-east India, primarily the Khasi people 
            in the state of Meghalaya. It has associate official status in some districts of this state. 
            The closest relatives of Khasi are the other languages in the Khasic group of the Shillong Plateau; 
            these include Pnar, Lyngngam and War.',
        ]);

        // Add more lesson data as needed
    }
}
