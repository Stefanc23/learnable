<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    // get user details
    public function index()
    {
        return response([
            'user' => Auth::user()
        ], 200);
    }

    // update user
    public function update(Request $request)
    {
        $user = $request->user();

        $attrs = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|email:dns|max:255|unique:users,email,'.$user->id,
            'phone_number' => 'required|string',
            'date_of_birth' => 'required',
            'gender' => 'required',
        ]);

        $user->update([
            'name' => $attrs['name'],
            'email' => $attrs['email'],
            'phone_number' => $attrs['phone_number'],
            'date_of_birth' =>  Carbon::createFromFormat('d/m/Y', $attrs['date_of_birth']),
            'gender' => $attrs['gender']
        ]);

        if(request()->hasFile('profile')) {
            if(Storage::exists($user->profile_image_file_path)){
                Storage::delete($user->profile_image_file_path);
            }
            $profile_image = $request->file('profile');
            $profile_image_file_name = 'profile-image-'.$user->id.'-'.time().'.'.$profile_image->getClientOriginalExtension();
            $profile_image_file_path = $profile_image->storeAs('profile-images', $profile_image_file_name);
            $user->update([
                'profile_image_file_path' => $profile_image_file_path
            ]);
        }

        return response([
            'message' => 'User updated.',
            'user' => auth()->user()
        ], 200);
    }
}
