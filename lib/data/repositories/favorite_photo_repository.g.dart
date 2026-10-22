// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_photo_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favoritePhotoRepository)
final favoritePhotoRepositoryProvider = FavoritePhotoRepositoryProvider._();

final class FavoritePhotoRepositoryProvider
    extends
        $FunctionalProvider<
          FavoritePhotoRepository,
          FavoritePhotoRepository,
          FavoritePhotoRepository
        >
    with $Provider<FavoritePhotoRepository> {
  FavoritePhotoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritePhotoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritePhotoRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavoritePhotoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoritePhotoRepository create(Ref ref) {
    return favoritePhotoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoritePhotoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoritePhotoRepository>(value),
    );
  }
}

String _$favoritePhotoRepositoryHash() =>
    r'b5cd6bee827b38bb2f860e75a0f47a095e71e3cc';
