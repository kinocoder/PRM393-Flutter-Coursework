// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhotoViewModel)
final photoViewModelProvider = PhotoViewModelProvider._();

final class PhotoViewModelProvider
    extends $AsyncNotifierProvider<PhotoViewModel, List<PhotoApiModel>> {
  PhotoViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoViewModelHash();

  @$internal
  @override
  PhotoViewModel create() => PhotoViewModel();
}

String _$photoViewModelHash() => r'2bdc9f6dd29782303efe2cfbbb32dce6df908c67';

abstract class _$PhotoViewModel extends $AsyncNotifier<List<PhotoApiModel>> {
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
