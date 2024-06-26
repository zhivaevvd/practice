<?php

namespace Database\Seeders;

use App\Models\Group;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class GroupSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Group::create([
            'name' => '104',
        ]);

        Group::create([
            'name' => '102М',
        ]);

        Group::create([
            'name' => '401',
        ]);

        Group::create([
            'name' => '302',
        ]);
    }
}
