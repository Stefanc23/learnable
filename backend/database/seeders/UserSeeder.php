<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'name' => 'Instructor Tester',
            'email' => 'instructor@learnable.com',
            'password' => Hash::make('abcd1234'),
            'phone_number' => '081227477221',
            'date_of_birth' => Carbon::createFromFormat('Y-m-d', '2001-10-23')->format('Y-m-d'),
            'gender' => 'Male'
        ]);

        User::create([
            'name' => 'Student Tester',
            'email' => 'student@learnable.com',
            'password' => Hash::make('abcd1234'),
            'phone_number' => '081277532383',
            'date_of_birth' => Carbon::createFromFormat('Y-m-d', '2001-10-22')->format('Y-m-d'),
            'gender' => 'Female'
        ]);
    }
}
