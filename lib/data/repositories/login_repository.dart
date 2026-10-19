import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoc_tren_truong/domain/models/users.dart';


import 'package:riverpod_annotation/riverpod_annotation.dart';

part "login_repository.g.dart";
@riverpod
LoginRepository loginRepository(Ref ref) {
  return LoginRepository();
}

class LoginRepository {
  final List<User> _users = [
    User(username: 'admin', password: '123456'),
    User(username: 'user', password: '123456'),
  ];

  // Trả về người dùng nếu thông tin đăng nhập chính xác.
  // Trả về null nếu tên đăng nhập hoặc mật khẩu không đúng.
  Future<User?> login({
    required String username,
    required String password,
  }) async {
    final normalizedUsername = username.trim();

    for (final user in _users) {
      if (user.username == normalizedUsername && user.password == password) {
        return user;
      }
    }

    return null;
  }
}
