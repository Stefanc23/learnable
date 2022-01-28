<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClassAttendee extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'classroom_id',
        'role'
    ];
}
