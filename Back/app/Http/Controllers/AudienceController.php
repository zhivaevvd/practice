<?php

namespace App\Http\Controllers;

use App\Models\Audience;
use Illuminate\Http\Request;

class AudienceController extends Controller
{
    public function index()
    {
        return response()->json(Audience::all());
    }
}
