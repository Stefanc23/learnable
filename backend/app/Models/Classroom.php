<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Traits\Uuids;

class Classroom extends Model
{
    use HasFactory, Uuids;

    protected $fillable = [
        'name',
        'invite_code',
        'banner_image_file_path'
    ];

    public function classAttendees()
    {
        return $this->belongsToMany(User::class, 'class_attendees')->withPivot('role');
    }
}
