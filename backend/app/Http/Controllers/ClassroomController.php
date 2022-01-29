<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Classroom;
use App\Models\ClassAttendee;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class ClassroomController extends Controller
{
    public function create($id) {
        return Inertia::render('Classroom', [
            'classroom' => Classroom::with('classAttendees')->find($id)
        ]);
    }
}
