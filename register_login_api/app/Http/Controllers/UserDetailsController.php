<?php

namespace App\Http\Controllers;
use App\Models\User; 
use Illuminate\Http\Request;
use App\Http\Resources\UserResource;
class UserDetailsController extends Controller
{
    /**
     * Get user details by user ID.
     *
     * @param int $userId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getUserDetails($userId)
    {
        try {
            // Retrieve user details from the database
            $user = User::findOrFail($userId);

            // Return user details as JSON response
            return response()->json([
                'success' => true,
                'data' => $user,
            ], 200);
        } catch (\Exception $e) {
            // Return error response if user is not found or any other error occurs
            return response()->json([
                'success' => false,
                'message' => 'Failed to load user details.',
            ],400);
        }
    }
}
