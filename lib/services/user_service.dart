import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:learnable/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:learnable/constants.dart';
import 'package:learnable/models/user.dart';

// get token
String getToken() {
  final box = GetStorage();
  return box.read('token') ?? '';
}

// get user id
int getUserId() {
  final box = GetStorage();
  return box.read('userId') ?? 0;
}

// login
Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});

    apiResponse.statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = invalidCredentials;
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

// Register
Future<ApiResponse> register(String name, String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(registerURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password
    });

    apiResponse.statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
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

// User
Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = getToken();
    final response = await http.get(Uri.parse(userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    apiResponse.statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
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

// Update user
// Future<ApiResponse> updateUser(String name, String? image) async {
//   ApiResponse apiResponse = ApiResponse();
//   try {
//     String token = await getToken();
//     final response = await http.put(Uri.parse(userURL),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//         body: image == null
//             ? {
//                 'name': name,
//               }
//             : {'name': name, 'image': image});
//     // user can update his/her name or name and image

//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = jsonDecode(response.body)['message'];
//         break;
//       case 401:
//         apiResponse.error = unauthorized;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }

// logout
Future<ApiResponse> logout() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = getToken();
    final response = await http.post(Uri.parse(logoutURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    apiResponse.statusCode = response.statusCode;

    switch (response.statusCode) {
      case 200:
        final box = GetStorage();
        box.remove('token');
        box.remove('userId');
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

// Get base64 encoded image
// String? getStringImage(File? file) {
//   if (file == null) return null ;
//   return base64Encode(file.readAs