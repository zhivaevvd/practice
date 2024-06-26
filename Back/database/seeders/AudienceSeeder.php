<?php

namespace Database\Seeders;

use App\Models\Audience;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AudienceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Audience::create([
            'number' => 201,
        ]);

        Audience::create([
            'number' => 413,
        ]);

        Audience::create([
            'number' => 109,
        ]);

        Audience::create([
            'number' => 211,
        ]);

        Audience::create([
            'number' => 589,
        ]);

        Audience::create([
            'number' => 104,
        ]);
    }
}
