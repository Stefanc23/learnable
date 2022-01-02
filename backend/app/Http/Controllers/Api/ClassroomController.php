<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Classroom;
use App\Models\ClassAttendee;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class ClassroomController extends Controller
{
    public function index() {
        return response([
            'attendedClasses' => Auth::user()->attendedClasses
        ], 200);
    }

    public function getAttendees(Request $request) {
        return response([
            'attendees' => Classroom::find($request->id)->classAttendees
        ], 200);
    }

    public function create(Request $request)
    {
        $attrs = $request->validate([
            'name' => 'required|max:255',
            'invite_code' => 'required|string|max:255',
        ]);

        $classroom = Classroom::create([
            'name' => $attrs['name'],
            'invite_code' => $attrs['invite_code']
        ]);

        ClassAttendee::create([
            'user_id' => Auth::id(),
            'classroom_id' => $classroom->id,
            'role' => 'Instructor'
        ]);

        if (request()->hasFile('banner')) {
            $banner_image = $request->file('banner');
            $banner_image_file_path = 'banner-image-' . $classroom->id . '-' . time() . '.' . $banner_image->getClientOriginalExtension();
            $banner_image_file_path = $banner_image->storeAs('banner-images', $banner_image_file_path);
            $classroom->update([
                'banner_image_file_path' => $banner_image_file_path
            ]);
        }
        
        return response([
            'classroom' => Classroom::with('classAttendees')->find($classroom->id)
        ], 200);
    }

    public function join(Request $request)
    {
        $attrs = $request->validate([
            'classroom_id' => 'required|string',
            'invite_code' => 'required|string|max:255',
        ]);

        $classroom = Classroom::find($attrs['classroom_id']);

        if ($classroom != null) {
            if ($classroom->invite_code == $attrs['invite_code']) {
                ClassAttendee::create([
                    'user_id' => Auth::id(),
                    'classroom_id' => $classroom->id,
                    'role' => 'Student'
                ]);

                return response([
                    'classroom' => Classroom::with('classAttendees')->find($classroom->id)
                ], 200);
            }
        }

        return response([
            'message' => 'Invalid credentials.',
        ], 401);
    }

    public function update(Request $request)
    {
        $classroom = Classroom::find($request->id);

        $attrs = $request->validate([
            'name' => 'required|string|max:255',
            'invite_code' => 'required|string|max:255'
        ]);

        $classroom->update([
            'name' => $attrs['name'],
            'invite_code' => $attrs['invite_code']
        ]);

        if (request()->hasFile('banner')) {
            if (Storage::exists($classroom->banner_image_file_path)) {
                Storage::delete($classroom->banner_image_file_path);
            }
            $banner_image = $request->file('banner');
            $banner_image_file_path = 'banner-image-' . $classroom->id . '-' . time() . '.' . $banner_image->getClientOriginalExtension();
            $banner_image_file_path = $banner_image->storeAs('banner-images', $banner_image_file_path);
            $classroom->update([
                'banner_image_file_path' => $banner_image_file_path
            ]);
        }

        return response([
            'message' => 'Classroom updated.',
            'classroom' => Classroom::with('classAttendees')->find($classroom->id)
        ], 200);
    }

    public function dismissStudent(Request $request) {
        ClassAttendee::where('user_id', '=', $request['user_id'])->where('classroom_id', '=', $request['classroom_id'])->delete();

        return response([
            'message' => 'Student dismissed.',
            'classroom' => Classroom::with('classAttendees')->find($request['classroom_id'])
        ], 200);
    }

    public function delete(Request $request) {
        $classAttendees = ClassAttendee::where('classroom_id', '=', $request['classroom_id']);
        foreach($classAttendees as $classAttendee) {
            $classAttendee->delete();
        }

        Classroom::find($request['classroom_id'])->delete();

        return response([
            'message' => 'Class deleted.',
        ], 200);
    }
}
