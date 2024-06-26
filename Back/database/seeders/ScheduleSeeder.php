<?php

namespace Database\Seeders;

use App\Models\Schedule;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ScheduleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Schedule::create([
            'date' => '2024-06-19 09:00:00',
            'teacher_id' => 4,
            'group_id' => 2,
            'class_id' => 2,
            'lesson_id' => 3,
            'pair_number' => 1,
        ]);

        Schedule::create([
            'date' => '2024-06-20 10:45:00',
            'teacher_id' => 4,
            'group_id' => 2,
            'class_id' => 2,
            'lesson_id' => 3,
            'pair_number' => 2,
        ]);
    }
}
