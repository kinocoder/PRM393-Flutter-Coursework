// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseAuth)
final firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends
        $FunctionalProvider<
          firebase_auth.FirebaseAuth,
          firebase_auth.FirebaseAuth,
          firebase_auth.FirebaseAuth
        >
    with $Provider<firebase_auth.FirebaseAuth> {
  FirebaseAuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAuthProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<firebase_auth.FirebaseAuth> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  firebase_auth.FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(firebase_auth.FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<firebase_auth.FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'dffd78b4e77d56a1066f36e3d8d40a004d636084';

@ProviderFor(userService)
final userServiceProvider = UserServiceProvider._();

final class UserServiceProvider
    extends $FunctionalProvider<UserService, UserService, UserService>
    with $Provider<UserService> {
  UserServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userServiceHash();

  @$internal
  @override
  $ProviderElement<UserService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserService create(Ref ref) {
    return userService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserService>(value),
    );
  }
}

String _$userServiceHash() => r'bfb8a9111b676c5fb7cefcac78865541bc641904';
