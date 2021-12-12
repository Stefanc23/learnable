<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'email' => 'required|email|email:dns|max:255',
            'password' => 'required|min:6|max:255'
        ]);

        if ($validate->fails()) {
            return response([
                'message' => 'The given data is invalid.',
                'errors' => $validate->errors(),
            ], 422);
        } else {
            $credentials = request(['email', 'password']);
            if (!Auth::attempt($credentials)) {
                return response([
                    'message' => 'Invalid credentials.',
                ], 401);
            }

            $user = User::where('email', $request->email)->first();

            return response([
                'user' => $user,
                'token' => $user->createToken('secret')->plainTextToken
            ], 200);
        }
    }

    // register
    public function register(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'name' => 'required|max:255',
            'email' => 'required|email|email:dns|unique:users|max:255',
            'password' => 'required|confirmed|min:6|max:255'
        ]);

        if ($validate->fails()) {
            return response([
                'message' => 'The given data is invalid.',
                'errors' => $validate->errors(),
            ], 422);
        } else {
            $user = User::create([
                'name' => $request['name'],
                'email' => $request['email'],
                'password' => Hash::make($request['password']),
            ]);

            auth()->login($user);

            return response([
                'user' => $user,
                'token' => $user->createToken('secret')->plainTextToken
            ], 200);
        }
    }

    // logout
    public function logout(Request $request)
    {
        $user = $request->user();
        $user->currentAccessToken()->delete();
        return response([
            'message' => 'Logout success.'
        ], 200);
    }

    // logout all sessions/devices
    public function logoutAll(Request $request)
    {
        $user = $request->user();
        $user->tokens()->delete();
        return response([
            'message' => 'Logout success.'
        ], 200);
    }

    // get user details
    public function user()
    {
        return response([
            'user' => Auth::user()
        ], 200);
    }

    // update user
    //  public function update(Request $request)
    //  {
    //      $attrs = $request->validate([
    //          'name' => 'required|string'
    //      ]);

    //      $image = $this->saveImage($request->image, 'profiles');

    //      $user = $request->user();

    //      $user->update([
    //          'name' => $attrs['name'],
    //          'image' => $image
    //      ]);

    //      return response([
    //          'message' => 'User updated.',
    //          'user' => auth()->user()
    //      ], 200);
    //  }
}
