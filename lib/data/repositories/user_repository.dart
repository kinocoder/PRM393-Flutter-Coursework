import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:hoc_tren_truong/data/services/user_service.dart';
import 'package:hoc_tren_truong/domain/models/users.dart' as domain;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  return UserRepository(ref.watch(userServiceProvider));
}

@Riverpod(keepAlive: true)
Stream<firebase_auth.User?> authStateChanges(Ref ref) {
  return ref.watch(userRepositoryProvider).authStateChanges();
}

class UserRepository {
  UserRepository(this._userService);

  final UserService _userService;

  firebase_auth.User? get currentUser => _userService.currentUser;

  Stream<firebase_auth.User?> authStateChanges() {
    return _userService.authStateChanges();
  }

  Future<firebase_auth.UserCredential> login(domain.User user) {
    return _userService.login(
      email: user.username.trim(),
      password: user.password,
    );
  }

  Future<firebase_auth.UserCredential> register(domain.User user) {
    return _userService.register(
      email: user.username.trim(),
      password: user.password,
    );
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _userService.sendPasswordResetEmail(email.trim());
  }

  Future<void> logout() {
    return _userService.logout();
  }
}
