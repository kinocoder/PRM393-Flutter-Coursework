// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(themeRepository)
final themeRepositoryProvider = ThemeRepositoryProvider._();

final class ThemeRepositoryProvider
    extends
        $FunctionalProvider<ThemeRepository, ThemeRepository, ThemeRepository>
    with $Provider<ThemeRepository> {
  ThemeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeRepositoryHash();

  @$internal
  @override
  $ProviderElement<ThemeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeRepository create(Ref ref) {
    return themeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeRepository>(value),
    );
  }
}

String _$themeRepositoryHash() => r'13bd895cf7f3609fbdb7914570d977119bb99a7f';
