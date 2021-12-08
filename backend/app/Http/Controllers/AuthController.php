<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request) {
        $validate = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required',
        ]);

        if ($validate->fails()) {
            $res = [
                'status' => 'error',
                'msg' => 'Validator error',
                'errors' => $validate->errors(),
                'content' => null,
            ];
            return response()->json($res, 200);
        } else {
            $credentials = request(['email', 'password']);
            if (!Auth::attempt($credentials)) {
                $res = [
                    'status' => 'error',
                    'msg' => 'Unathorized',
                    'errors' => null,
                    'content' => null,
                ];
                return response()->json($res, 401);
            }

            $user = User::where('email', $request->email)->first();
            if (!Hash::check($request->password, $user->password, [])) {
                throw new \Exception('Login error');
            }

            $tokenResult = $user->createToken('token-auth')->plainTextToken;
            $res = [
                'status' => 'success',
                'msg' => 'Login successfull!',
                'errors' => null,
                'content' => [
                    'status_code' => 200,
                    'access_token' => $tokenResult,
                    'token_type' => 'Bearer',
                    'user' => $user,
                ]
            ];
            return response()->json($res, 200);
        }
    }

    public function register(Request $request) {
        $validate = Validator::make($request->all(), [
            'name' => 'required|max:255',
            'email' => 'required|email|email:dns|unique:users|max:255',
            'password' => 'required|max:255',
        ]);

        if ($validate->fails()) {
            $res = [
                'status' => 'error',
                'msg' => 'Validator error',
                'errors' => $validate->errors(),
                'content' => null,
            ];
            return response()->json($res, 200);
        } else {
            $user = User::create([
                'name' => $request['name'],
                'email' => $request['email'],
                'password' => Hash::make($request['password']),
            ]);

            auth()->login($user);

            $tokenResult = $user->createToken('token-auth')->plainTextToken;
    
            $res = [
                'status' => 'success',
                'msg' => 'Registration successfull! User logged in!',
                'errors' => null,
                'content' => [
                    'status_code' => 200,
                    'access_token' => $tokenResult,
                    'token_type' => 'Bearer',
                    'user' => $user,
                ]
            ];
            return response()->json($res, 200);
        }
    }    

    public function logout(Request $request) {
        $user = $request->user();
        $user->currentAccessToken()->delete();
        $res = [
            'status' => 'success',
            'msg' => 'Logout successfull!',
            'errors' => null,
            'content' => null,
        ];
        return response()->json($res, 200);
    }

    public function logoutAll(Request $request) {
        $user = $request->user();
        $user->tokens()->delete();
        $res = [
            'status' => 'success',
            'msg' => 'Logout successfull!',
            'errors' => null,
            'content' => null,
        ];
        return response()->json($res, 200);
    }
}
