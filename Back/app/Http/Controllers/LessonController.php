<?php

namespace App\Http\Controllers;

use App\Models\Lesson;
use App\Models\Person;
use Illuminate\Http\Request;

class LessonController extends Controller
{
    public function index()
    {
        return response()->json(['lessons' => Lesson::all()]);
    }

    public function getByTeacherId(int $teacherId)
    {
        $lessons = Lesson::where('teacher_id', $teacherId)->get();

        return response()->json(['lessons' => $lessons]);
    }
}
