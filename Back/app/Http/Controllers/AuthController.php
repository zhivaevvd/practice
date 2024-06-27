<?php

namespace App\Http\Controllers;

use App\Models\Auth;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $login = $request->get('login');
        $password = $request->get('password');

        $auth = Auth::where('login', $login)
            ->where('password', $password)
            ->first();

        if ($auth === null)
            return response()->json(['message' => 'Login not found'], 422);

        return response()->json($auth);
    }
}
