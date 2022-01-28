<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Classroom;
use App\Models\ClassAttendee;

class ClassAttendeeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        ClassAttendee::create([
            'user_id' => 1,
            'classroom_id' => Classroom::first()['id'],
            'role' => 'Instructor'
        ]);

        ClassAttendee::create([
            'user_id' => 2,
            'classroom_id' => Classroom::first()['id'],
            'role' => 'Student'
        ]);
    }
}
