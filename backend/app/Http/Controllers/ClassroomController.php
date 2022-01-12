<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\User;
use App\Models\Classroom;
use App\Models\ClassAttendee;
use App\Models\Material;
use App\Models\Assignment;
use App\Models\Submission;
use App\Models\SubmissionHistory;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;

class ClassroomController extends Controller
{
    public function create($id)
    {
        return Inertia::render('Classroom', [
            'classroom' => Classroom::with('classAttendees')->with('assignments')->with('assignments.submissions')->with('materials')->find($id),
            'assignments' => Assignment::with('submissions')->with('submissions.user')->with('submissionHistories', function ($query) {
                return $query->with('submission')->where('user_id', Auth::id())->orderBy('created_at', 'DESC');
            })->orderBy('created_at', 'DESC')->get(),
        ]);
    }

    public function update(Request $request, $id)
    {

        $attrs = $request->validate([
            'name' => 'required|string',
            'invite_code' => 'required|string|max:255',
        ]);

        $classroom = Classroom::find($id);

        if ($classroom != null) {
            $classroom->update([
                'name' => $attrs['name'],
                'invite_code' => $attrs['invite_code'],
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

            return redirect()->back()->with('message', 'Classroom detail updated!');
        }
    }

    public function addAssignment(Request $request, $classroomId)
    {
        $attrs = $request->validate([
            'title' => 'required|max:255',
            'deadline' => 'required'
        ]);

        $assignment = $request->file('assignment');
        $assignment_file_path = 'assignment-' . $attrs['title'] . '-' . time() . '.' . $assignment->getClientOriginalExtension();
        $assignment_file_path = $assignment->storeAs('assignments', $assignment_file_path);

        $assignment = Assignment::create([
            'title' => $attrs['title'],
            'deadline' => Carbon::createFromFormat('Y-m-d H:i', $attrs['deadline'])->format('Y-m-d H:i'),
            'assignment_file_path' => $assignment_file_path,
            'classroom_id' => $classroomId
        ]);

        return redirect()->back()->with('message', 'Assignment added!');
    }

    public function deleteAssignment($assignmentId)
    {
        $assignment = Assignment::find($assignmentId);
        if (Storage::exists($assignment->assignment_file_path)) {
            Storage::delete($assignment->assignment_file_path);
        }
        $assignment->delete();

        return redirect()->back()->with('message', 'Assignment deleted!');
    }

    public function addSubmission(Request $request, $assignmentId)
    {
        $attrs = $request->validate([
            'title' => 'required|max:255',
        ]);

        $submission = Submission::where('user_id', Auth::id())->where('assignment_id', $assignmentId)->first();

        if ($submission == null) {
            $new_submission = $request->file('submission');
            $submission_file_path = 'submission-' . $attrs['title'] . '-' . time() . '.' . $new_submission->getClientOriginalExtension();
            $submission_file_path = $new_submission->storeAs('submissions', $submission_file_path);

            $submission = Submission::create([
                'title' => $attrs['title'],
                'submission_file_path' => $submission_file_path,
                'user_id' => Auth::id(),
                'assignment_id' => $assignmentId
            ]);
        } else {
            if (Storage::exists($submission->submission_file_path)) {
                Storage::delete($submission->submission_file_path);
            }

            $new_submission = $request->file('submission');
            $submission_file_path = 'submission-' . $attrs['title'] . '-' . time() . '.' . $new_submission->getClientOriginalExtension();
            $submission_file_path = $new_submission->storeAs('submissions', $submission_file_path);

            $submission->update([
                'title' => $attrs['title'],
                'submission_file_path' => $submission_file_path,
                'user_id' => Auth::id(),
                'assignment_id' => $assignmentId
            ]);
        }

        SubmissionHistory::create([
            'title' => $attrs['title'],
            'user_id' => Auth::id(),
            'assignment_id' => $assignmentId,
            'submission_id' => $submission->id,
        ]);

        return redirect()->back()->with('message', 'Submission added!');
    }

    public function addMaterial(Request $request, $classroomId)
    {
        $attrs = $request->validate([
            'title' => 'required|max:255',
        ]);

        $material = $request->file('material');
        $material_file_path = 'material-' . $attrs['title'] . '-' . time() . '.' . $material->getClientOriginalExtension();
        $material_file_path = $material->storeAs('materials', $material_file_path);

        $material = Material::create([
            'title' => $attrs['title'],
            'material_file_path' => $material_file_path,
            'classroom_id' => $classroomId
        ]);

        return redirect()->back()->with('message', 'Material added!');
    }

    public function deleteMaterial($materialId)
    {
        $material = Material::find($materialId);
        if (Storage::exists($material->material_file_path)) {
            Storage::delete($material->material_file_path);
        }
        $material->delete();

        return redirect()->back()->with('message', 'Material deleted!');
    }
}
