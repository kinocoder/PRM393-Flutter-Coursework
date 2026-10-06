// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartRepository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cartRepository)
final cartRepositoryProvider = CartRepositoryProvider._();

final class CartRepositoryProvider
    extends $FunctionalProvider<Cartrepository, Cartrepository, Cartrepository>
    with $Provider<Cartrepository> {
  CartRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartRepositoryHash();

  @$internal
  @override
  $ProviderElement<Cartrepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Cartrepository create(Ref ref) {
    return cartRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Cartrepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Cartrepository>(value),
    );
  }
}

String _$cartRepositoryHash() => r'3d9fc865d990066154d8498eb6fa6e48aa3c79ba';
