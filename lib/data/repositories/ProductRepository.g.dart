// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductRepository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productrepository)
final productrepositoryProvider = ProductrepositoryProvider._();

final class ProductrepositoryProvider
    extends
        $FunctionalProvider<
          Productrepository,
          Productrepository,
          Productrepository
        >
    with $Provider<Productrepository> {
  ProductrepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productrepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productrepositoryHash();

  @$internal
  @override
  $ProviderElement<Productrepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Productrepository create(Ref ref) {
    return productrepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Productrepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Productrepository>(value),
    );
  }
}

String _$productrepositoryHash() => r'1481c9c419e8beb6efcd4b24609b5c3a0c340223';
