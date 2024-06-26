<?php

namespace Database\Seeders;

use App\Models\Person;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PersonSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Person::create([
            'auth_id' => 1,
            'name' => 'Влад',
            'surname' => 'Живаев',
            'type' => 'admin',
            'avatar_url' => 'https://sun9-46.userapi.com/impg/cVYVEFGaT6SEk0rJl48aHhuEvCCbA1jzJdEwxQ/chJ5LET6HPo.jpg?size=613x818&quality=95&sign=915d2c85c7bb958e1cda72eee43981d7&type=album',
        ]);

        Person::create([
            'auth_id' => 2,
            'name' => 'Константин',
            'surname' => 'Архипов',
            'type' => 'student',
            'avatar_url' => 'https://sun9-18.userapi.com/impg/RpcA0AgUFKil3Gm7A05ZfEKnMtT8Q2I8QtD_bQ/079_9ogKj7A.jpg?size=1216x2160&quality=95&sign=8d7cfc3a61436d6288c1216f6dbaa1ad&type=album',
        ]);

        Person::create([
            'auth_id' => 3,
            'name' => 'Максим',
            'surname' => 'Гурьянов',
            'type' => 'teacher',
            'avatar_url' => 'https://sun9-19.userapi.com/impg/-qE1h_elLU7RLppYfWkgAkHzOMu0U99IrWLiiw/aQ1wesZP0Ek.jpg?size=1443x2160&quality=95&sign=1a094ccc3c2c0b2da672cbec25a6303e&c_uniq_tag=JI1g4GW_R1CCxHXTyNtqoiFd9p-u6u58bH_ozuTdrvg&type=album',
        ]);

        Person::create([
            'auth_id' => 4,
            'name' => 'Антон',
            'surname' => 'Аверин',
            'type' => 'teacher',
            'avatar_url' => '',
        ]);

        Person::create([
            'auth_id' => 5,
            'name' => 'Сергей',
            'surname' => 'Кулебякин',
            'type' => 'teacher',
            'avatar_url' => '',
        ]);
    }
}
