<?php

// use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\ClassroomController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['prefix' => 'auth'], function() {
    Route::post('login', [AuthController::class, 'login']);
    Route::post('register', [AuthController::class, 'register']);
    Route::group(['middleware' => 'auth:sanctum'], function() {
        Route::post('logout', [AuthController::class, 'logout']);
        Route::post('logoutall', [AuthController::class, 'logoutAll']);
    });
});

Route::group(['middleware' => 'auth:sanctum'], function() {
    Route::get('/user', [UserController::class, 'index']);
    Route::post('/user', [UserController::class, 'update']);
    Route::get('/classroom', [ClassroomController::class, 'index']);
    Route::post('/classroom', [ClassroomController::class, 'create']);
    Route::group(['prefix' => 'classroom'], function() {
        Route::post('/attendees', [ClassroomController::class, 'getAttendees']);
        Route::post('/join', [ClassroomController::class, 'join']);
        Route::post('/update', [ClassroomController::class, 'update']);
        Route::post('/dismiss', [ClassroomController::class, 'dismissStudent']);
        Route::post('/delete', [ClassroomController::class, 'delete']);
    });
});