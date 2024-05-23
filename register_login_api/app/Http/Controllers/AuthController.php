<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User; 

class AuthController extends Controller {
    
    public function register(Request $request) {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => 400, 'errors' => $validator->errors()], 400);
        }
        try {
            $user = new User();
            $user->email = $request->email;
            $user->password = Hash::make($request->password);
            $user->save();
            $response = ['status' => 200, 'message' => 'Registered Successfully'];
            return response()->json($response);
        } catch (\Exception $e) {
            $response = ['status' => 500, 'message' => 'Registration failed: ' . $e->getMessage()];
            return response()->json($response, 500);
        }
    }

    public function login(Request $request) {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json(['status' => 400, 'errors' => $validator->errors()], 400);
        }
        $user = User::where('email', $request->email)->first();

        if($user && Hash::check($request->password, $user->password)){
            $token = $user->createToken('auth_token')->plainTextToken;
            $userId = $user->id;
            $response=['email'=> $request->email,'status' => 200, 'token' => $token, 'user' => $user, 'message' => 'Successfully Logged In', 'userId' => $userId];
            return response()->json($response);
        } elseif (!$user) {
            $response=['status' => 404, 'message' => 'No Account has been registered with this email'];
            return response()->json($response, 404);
        } else {
            $response=['status' => 401, 'message' => 'Wrong Email or Password'];
            return response()->json($response, 401);
        }
    }
}
