class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? dob;
  String? gender;
  String? profileImage;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.dob,
    this.gender,
    this.profileImage,
    this.token,
  });

  // function for converting json data to model data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone_number'] ?? '',
      dob: json['user']['date_of_birth'] ?? '',
      gender: json['user']['gender'] ?? '',
      profileImage: json['user']['profile_image_file_path'] ?? '',
      token: json['token'],
    );
  }
}
