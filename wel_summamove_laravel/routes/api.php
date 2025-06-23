<?php 
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PrestatieController;
use App\Http\Controllers\OefeningController;



Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'me']);
    Route::post('/logout', [AuthController::class, 'logout']);

    Route::apiResource('prestaties', PrestatieController::class);
    Route::apiResource('oefeningen', OefeningController::class)->only(['index', 'show']);
});
