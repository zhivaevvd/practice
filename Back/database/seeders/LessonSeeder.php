<?php

namespace Database\Seeders;

use App\Models\Lesson;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class LessonSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Lesson::create([
            'name' => 'Мат.анализ',
            'teacher_id' => 3,
        ]);

        Lesson::create([
            'name' => 'Англ.яз',
            'teacher_id' => 3,
        ]);

        Lesson::create([
            'name' => 'Функциональный анализ',
            'teacher_id' => 4,
        ]);

        Lesson::create([
            'name' => 'Теория чисел',
            'teacher_id' => 5,
        ]);

        Lesson::create([
            'name' => 'Русский язык',
            'teacher_id' => 5,
        ]);

        Lesson::create([
            'name' => 'ТФКП',
            'teacher_id' => 5,
        ]);
    }
}
