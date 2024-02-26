<?php

namespace App\Http\Controllers;
use App\Models\User; 
use Illuminate\Http\Request;
use App\Http\Resources\UserResource;
class UserDetailsController extends Controller
{
    public function getDetails(Request $r,$id){
        $user = User::find($id);//select * from users where id
        if(!$user){//checking for user
            return response()->json(['status' => 400, Message => 'User Not Found'], 400);
        }
        else{
            return response()->json([
                "data" => new UserResource($user),//call UserResource
            ],200);
        }
    }
}
