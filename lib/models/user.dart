class User {
  int? id;
  String? name;
  String? email;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  // function for converting json data to model data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['token'],
    );
  }
}
