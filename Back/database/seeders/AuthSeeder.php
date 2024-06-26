<?php

namespace Database\Seeders;

use App\Models\Auth;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AuthSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Auth::create([
            'login' => 'vlad',
            'password' => 'pass',
        ]);

        Auth::create([
            'login' => 'konstantin',
            'password' => '1234',
        ]);

        Auth::create([
            'login' => 'max',
            'password' => 'qwerty',
        ]);
    }
}
