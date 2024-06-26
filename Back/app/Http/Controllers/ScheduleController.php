<?php

namespace App\Http\Controllers;

use App\Models\Audience;
use App\Models\Group;
use App\Models\Lesson;
use App\Models\Person;
use App\Models\Schedule;
use Illuminate\Http\Request;

class ScheduleController extends Controller
{
    public function getByGroupId(int $groupId)
    {
        $schedules = Schedule::where('group_id', $groupId)->get();
        $response = [];

        foreach ($schedules as $schedule) {
            $teacher = Person::find($schedule->teacher_id);

            $response[] = [
                'lessonId' => $schedule->lesson_id,
                'lessonName' => Lesson::find($schedule->lesson_id)->name,
                'date' => $schedule->date,
                'teacher' => "{$teacher->name} {$teacher->surname}",
                'group' => Group::find($schedule->group_id)->name,
                'class' => Audience::find($schedule->class_id)->number,
                'scheduleId' => $schedule->id,
                'pairNumber' => $schedule->pair_number,
            ];
        }
        return response()->json($response);
    }
}
