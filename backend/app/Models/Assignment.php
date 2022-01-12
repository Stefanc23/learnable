<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Assignment extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'deadline',
        'assignment_file_path',
        'classroom_id'
    ];

    public function classroom()
    {
        return $this->belongsTo(Classroom::class);
    }

    public function submissions()
    {
        return $this->hasMany(Submission::class);
    }

    public function submissionHistories()
    {
        return $this->hasMany(SubmissionHistory::class);
    }
}
