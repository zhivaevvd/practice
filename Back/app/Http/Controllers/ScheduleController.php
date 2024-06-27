<?php

namespace App\Http\Controllers;

use App\Http\Requests\ScheduleRequest;
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
            $response[] = [
                'lessonId' => $schedule->lesson_id,
                'lessonName' => Lesson::find($schedule->lesson_id)->name,
                'date' => $schedule->date,
                'teacher' => Person::find($schedule->teacher_id),
                'group' => Group::find($schedule->group_id),
                'class' => Audience::find($schedule->class_id),
                'scheduleId' => $schedule->id,
                'pairNumber' => $schedule->pair_number,
            ];
        }
        return response()->json($response);
    }

    public function store(ScheduleRequest $request)
    {
        $validated = $request->validated();

        try
        {
            $schedule = new Schedule();
            $schedule->date = $validated['date'];
            $schedule->teacher_id = $validated['teacherId'];
            $schedule->group_id = $validated['groupId'];
            $schedule->class_id = $validated['classId'];
            $schedule->lesson_id = $validated['lessonId'];
            $schedule->pair_number = $validated['pairNumber'];
            $schedule->save();

            return response()->json([
                'success' => true,
                'error' => null,
            ]);
        }
        catch (\Throwable $e)
        {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ]);
        }
    }

    public function update(Schedule $schedule, ScheduleRequest $request)
    {
        $validated = $request->validated();

        try
        {
            $schedule->date = $validated['date'];
            $schedule->teacher_id = $validated['teacherId'];
            $schedule->group_id = $validated['groupId'];
            $schedule->class_id = $validated['classId'];
            $schedule->lesson_id = $validated['lessonId'];
            $schedule->pair_number = $validated['pairNumber'];
            $schedule->save();

            return response()->json([
                'success' => true,
                'error' => null,
            ]);
        }
        catch (\Throwable $e)
        {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ]);
        }
    }

    public function destroy(Schedule $schedule)
    {
        try
        {
            $schedule->delete();

            return response()->json([
                'success' => true,
                'error' => null,
            ]);
        }
        catch (\Throwable $e)
        {
            return response()->json([
                'success' => false,
                'error' => $e->getMessage(),
            ]);
        }
    }
}
