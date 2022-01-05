import 'package:learnable/models/classroom.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? gender;
  String? profileImage;
  String? role;
  String? token;
  List<Classroom>? classrooms;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.dob,
      this.gender,
      this.profileImage,
      this.role,
      this.token,
      this.classrooms});

  // function for converting json data to model data
  factory User.fromJson(Map<String, dynamic> json) {
    List<Classroom> classrooms = [];
    List<dynamic> attendedClasses = json['user']['attended_classes'];
    for (var i = 0; i < attendedClasses.length; ++i) {
      classrooms.add(Classroom(
          id: attendedClasses[i]['id'],
          name: attendedClasses[i]['name'],
          inviteCode: attendedClasses[i]['invite_code'],
          bannerImage: attendedClasses[i]['banner_image_file_path'],
          role: attendedClasses[i]['pivot']['role']));
    }
    User user = User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        phone: json['user']['phone_number'] ?? '',
        dob: json['user']['date_of_birth'] ?? '',
        gender: json['user']['gender'] ?? '',
        profileImage: json['user']['profile_image_file_path'] ?? '',
        token: json['token'],
        classrooms: classrooms);
    return user;
  }
}
