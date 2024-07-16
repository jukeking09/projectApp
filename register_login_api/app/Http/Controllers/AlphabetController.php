<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Alphabet;

class AlphabetController extends Controller
{
    public function getAlphabets($languageId)
    {
        $alphabets = Alphabet::where('language_id', $languageId)->get();
        return response()->json($alphabets);
    }
}
