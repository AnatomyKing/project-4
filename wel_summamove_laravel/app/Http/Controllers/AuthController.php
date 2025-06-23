<?php
namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\User;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $attr = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|unique:users,email',
            'password' => 'required|string|min:6|confirmed'
        ]);

        $user = User::create([
            'name' => $attr['name'],
            'password' => bcrypt($attr['password']),
            'email' => $attr['email']
        ]);

        return response()->json(['message' => 'Registration successful'], 200);
    }

    public function login(Request $request)
    {
        try {
            $attr = $request->validate([
                'email' => 'required|string|email',
                'password' => 'required|string|min:6'
            ]);

            if (!Auth::attempt($attr)) {
                return response()->json(['message' => 'Credentials not match'], 401);
            }

            $token = auth()->user()->createToken('API Token')->plainTextToken;

            return response()->json([
                'access_token' => $token,
                'token_type' => 'Bearer'
            ], 200);

        } catch (\Exception $e) {
            // Foutmelding direct teruggeven in JSON, handig voor debugging
            return response()->json([
                'error' => $e->getMessage(),
                'trace' => $e->getTrace()
            ], 500);
        }
    }

    public function logout()
    {
        auth()->user()->tokens()->delete();
        return response()->json(['message' => 'Tokens Revoked'], 200);
    }
}
