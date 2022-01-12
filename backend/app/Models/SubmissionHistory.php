<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubmissionHistory extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'submission_file_path',
        'user_id',
        'assignment_id',
        'submission_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function assignment()
    {
        return $this->belongsTo(Assignment::class);
    }

    public function submission()
    {
        return $this->belongsTo(Submission::class);
    }
}
