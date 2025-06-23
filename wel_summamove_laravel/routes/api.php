<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\PrestatieController;
use App\Http\Controllers\OefeningController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Publieke routes (geen authenticatie)
Route::get('/oefeningen', [OefeningController::class, 'index']);
Route::get('/oefeningen/{oefening}', [OefeningController::class, 'show']);


// Beveiligde routes (auth:sanctum)
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'me']);
    Route::post('/logout', [AuthController::class, 'logout']);

    // Prestaties beveiligd (GET per gebruiker + POST, PUT, DELETE)
    Route::get('/prestaties', [PrestatieController::class, 'index']);
    Route::post('/prestaties', [PrestatieController::class, 'store']);
    Route::put('/prestaties/{prestatie}', [PrestatieController::class, 'update']);
    Route::delete('/prestaties/{prestatie}', [PrestatieController::class, 'destroy']);

    // Oefeningen beveiligd (alleen POST, PUT, DELETE)
    Route::post('/oefeningen', [OefeningController::class, 'store']);
    Route::put('/oefeningen/{oefening}', [OefeningController::class, 'update']);
    Route::delete('/oefeningen/{oefening}', [OefeningController::class, 'destroy']);

    Route::apiResource('/users', UserController::class)->except(['index']);
 
});
  
Route::get('/users', [UserController::class, 'index']);