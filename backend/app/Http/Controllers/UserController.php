<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function create() {
        return Inertia::render('Profile', [
            'user' => User::with('attendedClasses')->find(Auth::id())
        ]);
    }

    public function update(Request $request) {
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
            'date_of_birth' =>  Carbon::createFromFormat('Y-m-d', $attrs['date_of_birth'])->format('Y-m-d'),
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

        return redirect()->route('user.profile')->with('message', 'Profile updated.');
    }

    public function changePassword(Request $request) {
        $request->validate([
            'current_password' => ['required', new MatchOldPassword],
            'new_password' => ['required'],
            'new_password_confirmation' => ['same:new_password'],
        ]);
   
        User::find(auth()->user()->id)->update(['password'=> Hash::make($request->new_password)]);

        return redirect()->route('user.profile')->with('message', 'Password updated.');
    }
}
