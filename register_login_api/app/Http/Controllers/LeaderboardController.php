<?php

// app/Http/Controllers/LeaderboardController.php

namespace App\Http\Controllers;

use App\Models\QuizScore;
use App\Models\User; // Assuming User model exists for user details
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LeaderboardController extends Controller
{
    public function index()
    {
        $leaderboard = QuizScore::select('user_id', DB::raw('SUM(score) as total_score'))
            ->groupBy('user_id')
            ->orderByDesc('total_score')
            ->take(5)
            ->get();

        // Optionally include user details
        $leaderboardWithUsers = [];
        foreach ($leaderboard as $entry) {
            $user = User::find($entry->user_id);
            $leaderboardWithUsers[] = [
                'user_id' => $entry->user_id,
                'score' => $entry->total_score,
                'email' => $user ? $user->email : 'Unknown User', // Adjust for your User model
            ];
        }

        return response()->json($leaderboardWithUsers);
    }
}

