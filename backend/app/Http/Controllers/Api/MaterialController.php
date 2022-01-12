<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Classroom;
use App\Models\Material;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class MaterialController extends Controller
{
    public function index(Request $request) {
        return response([
            'materials' => Classroom::find($request['id'])->materials()
        ], 200);
    }

    public function show($id) {
        return response([
            'material' => Material::find($id)
        ], 200); 
    }

    public function store(Request $request, $classroomId) {
        $attrs = $request->validate([
            'name' => 'required|max:255',
        ]);

        $material = $request->file('material');
        $material_file_path = 'material-' . $classroomId . '-' . time() . '.' . $material->getClientOriginalExtension();
        $material_file_path = $material->storeAs('materials', $material_file_path);

        $material = Material::create([
            'name' => $attrs['name'],
            'material_file_path' => $material_file_path
        ]);
        
        return response([
            'material' => $material
        ], 200);
    }

    public function delete($classroomId, $materialId) {
        $material = Material::find($materialId);
        if (Storage::exists($material->material_file_path)) {
            Storage::delete($material->material_file_path);
        }
        $material->delete();

        return response([
            'message' => 'Material deleted.',
        ], 200);
    }
}
