import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:learnable/constants.dart';
import 'package:learnable/models/api_response.dart';
import 'package:learnable/models/class_material.dart';
import 'package:learnable/services/user_service.dart';

Future<ApiResponse> getMaterials(String classroomId) async {
  ApiResponse apiResponse = ApiResponse();
  List<ClassMaterial> materials = [];

  try {
    String token = getToken();
    var dio = Dio();

    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.get('$classroomURL/$classroomId/materials');

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> json = response.data;
        List<dynamic> data = json['materials'];
        for (var i = 0; i < data.length; ++i) {
          materials.add(ClassMaterial(
              id: data[i]['id'],
              title: data[i]['title'],
              filePath: data[i]['material_file_path'],
              uploadDate:
                  DateTime.parse(data[i]['created_at']).toLocal().toString()));
        }
        apiResponse.data = materials;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e, stacktrace) {
    print(stacktrace.toString());
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> addMaterial(
    String classroomId, String title, PlatformFile file) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = getToken();
    var dio = Dio();
    var formData = FormData.fromMap({
      'title': title,
      'material': await MultipartFile.fromFile(file.path as String)
    });
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response =
        await dio.post('$classroomURL/$classroomId/materials', data: formData);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> json = response.data;
        apiResponse.data = ClassMaterial(
            id: json['material']['id'],
            title: json['material']['title'],
            filePath: json['material']['material_file_path'],
            uploadDate: DateTime.parse(json['material']['created_at'])
                .toLocal()
                .toString());
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> deleteMaterial(String materialId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = getToken();
    var dio = Dio();

    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.delete('$baseApiURL/materials/$materialId');

    switch (response.statusCode) {
      case 200:
        apiResponse.data = response.data['message'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e, stacktrace) {
    print(stacktrace.toString());
    apiResponse.error = serverError;
  }

  return apiResponse;
}
