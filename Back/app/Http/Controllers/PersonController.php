<?php

namespace App\Http\Controllers;

use App\Models\Person;
use Illuminate\Http\Request;

class PersonController extends Controller
{
    public function getById(Person $person)
    {
        return response()->json($person);
    }

    public function getTeachers()
    {
        $teachers = Person::where('type', 'teacher')->get();

        return response()->json($teachers);
    }
}
