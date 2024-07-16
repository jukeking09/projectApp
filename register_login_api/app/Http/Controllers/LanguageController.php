<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Language;
use App\Models\Lesson;
use App\Models\UserLanguage;
use Illuminate\Support\Facades\Auth;

class LanguageController extends Controller
{
    public function store(Request $request)
    {
        // Validate the request data
        $validated = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        // Create the language
        $language = Language::create([
            'name' => $validated['name'],
        ]);

        // Return a success response
        return response()->json([
            'status' => 200,
            'message' => 'Language added successfully',
            'language' => $language,
        ]);
    }
    public function getAvailableLanguages()
    {
        $languages = Language::all();
        return response()->json($languages);
    }
    public function getUserLanguages($userid){
        $languages = UserLanguage::where("user_id", $userid)->get()->all();
        return response()->json($languages);
    }

    public function saveUserLanguage(Request $request)
    {
        $request->validate([
            'userId' => 'required|integer|exists:users,id',
            'languageId' => 'required|integer|exists:languages,id',
        ]);

        $userLanguage = UserLanguage::updateOrCreate(
            ['user_id' => $request->userId],
            ['language_id' => $request->languageId]
        );

        return response()->json(['message' => 'User language saved successfully'], 200);
    }

    public function getLessonsByLanguage($languageId)
    {
            
        $lessons = Lesson::where('language_id', $languageId)->get();

        return response()->json($lessons, 200);
    }
}


