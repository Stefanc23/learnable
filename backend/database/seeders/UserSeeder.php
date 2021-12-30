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
            'name' => 'Stefano Christian Wiryana',
            'email' => 'stefano.wiryana@binus.ac.id',
            'password' => Hash::make('abcd1234'),
            'phone_number' => '08813373537',
            'date_of_birth' => Carbon::createFromFormat('Y-m-d', '2001-10-23')->format('Y-m-d'),
            'gender' => 'Male'
        ]);
    }
}
