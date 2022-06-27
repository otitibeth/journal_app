class User {
  final String email;
  final String password;
  final String? name;
  final String? uid;

  User({
    required this.email,
    required this.password,
    required this.uid,
    required this.name,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        password = json['password'],
        uid = json['uid'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'uid': uid,
      };
}
