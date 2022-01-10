import 'package:learnable/models/user.dart';

class Classroom {
  String? id;
  String? name;
  String? inviteCode;
  String? bannerImage;
  String? role;

  Classroom({this.id, this.name, this.inviteCode, this.bannerImage, this.role});

  factory Classroom.fromJson(Map<String, dynamic> json) {
    List<User> attendees = [];
    List<dynamic> classAttendees = json['classroom']['class_attendees'];
    for (var i = 0; i < classAttendees.length; ++i) {
      attendees.add(User(
          id: classAttendees[i]['id'],
          name: classAttendees[i]['name'],
          email: classAttendees[i]['email'],
          phone: classAttendees[i]['phone_number'] ?? '',
          dob: classAttendees[i]['date_of_birth'] ?? '',
          gender: classAttendees[i]['gender'] ?? '',
          profileImage: classAttendees[i]['profile_image_file_path'] ?? '',
          role: classAttendees[i]['pivot']['role']));
    }
    Classroom classroom = Classroom(
      id: json['classroom']['id'],
      name: json['classroom']['name'],
      inviteCode: json['classroom']['invite_code'],
      bannerImage: json['classroom']['banner_image_file_path'],
    );
    return classroom;
  }
}
