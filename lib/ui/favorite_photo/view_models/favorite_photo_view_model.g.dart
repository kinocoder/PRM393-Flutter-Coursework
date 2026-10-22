// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_photo_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritePhotoViewModel)
final favoritePhotoViewModelProvider = FavoritePhotoViewModelProvider._();

final class FavoritePhotoViewModelProvider
    extends
        $AsyncNotifierProvider<FavoritePhotoViewModel, List<PhotoApiModel>> {
  FavoritePhotoViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritePhotoViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritePhotoViewModelHash();

  @$internal
  @override
  FavoritePhotoViewModel create() => FavoritePhotoViewModel();
}

String _$favoritePhotoViewModelHash() =>
    r'db2050bca3995ad3b842c63b41accd7fe450cd58';

abstract class _$FavoritePhotoViewModel
    extends $AsyncNotifier<List<PhotoApiModel>> {
  FutureOr<List<PhotoApiModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PhotoApiModel>>, List<PhotoApiModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PhotoApiModel>>, List<PhotoApiModel>>,
              AsyncValue<List<PhotoApiModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
