<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Material extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'material_file_path',
        'classroom_id'
    ];

    public function classroom() {
        return $this->belongsTo(Classroom::class);
    }
}
