class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  User copyWith({String? username, String? password}) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
