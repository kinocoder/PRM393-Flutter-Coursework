import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

@Riverpod(keepAlive: true)
firebase_auth.FirebaseAuth firebaseAuth(Ref ref) {
  return firebase_auth.FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
UserService userService(Ref ref) {
  return UserService(ref.watch(firebaseAuthProvider));
}

/// Giao tiếp trực tiếp với Firebase Authentication.
class UserService {
  UserService(this._firebaseAuth);

  final firebase_auth.FirebaseAuth _firebaseAuth;

  firebase_auth.User? get currentUser => _firebaseAuth.currentUser;

  Stream<firebase_auth.User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<firebase_auth.UserCredential> login({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<firebase_auth.UserCredential> register({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() {
    return _firebaseAuth.signOut();
  }
}
