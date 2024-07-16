<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Audio;

class AudiosTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Sample audio data for different lessons
        $audios = [
            [
                'lesson_id' => 3,
                'word' => 'phi',
                'audio_url' => 'sounds/Phi.m4a',
            ],
            [
                'lesson_id' => 3,
                'word' => 'dang',
                'audio_url' => 'sounds/Dang.m4a',
            ],
            [
                'lesson_id' => 3,
                'word' => 'leh',
                'audio_url' => 'sounds/Leh.m4a',
            ],
            [
                'lesson_id' => 3,
                'word' => 'aiu',
                'audio_url' => 'sounds/Aiu.m4a',
            ],
        ];

        // Insert audio data into the database
        foreach ($audios as $audioData) {
            Audio::create($audioData);
        }
    }
}
