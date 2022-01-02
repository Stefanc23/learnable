<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Classroom;

class ClassroomSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Classroom::create([
            'name' => 'Test Classroom',
            'invite_code' => 'abcd1234',
        ]);
    }
}
