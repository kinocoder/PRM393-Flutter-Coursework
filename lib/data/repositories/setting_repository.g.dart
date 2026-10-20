// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingrepository1)
final settingrepository1Provider = Settingrepository1Provider._();

final class Settingrepository1Provider
    extends
        $FunctionalProvider<
          Settingrepository1,
          Settingrepository1,
          Settingrepository1
        >
    with $Provider<Settingrepository1> {
  Settingrepository1Provider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingrepository1Provider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingrepository1Hash();

  @$internal
  @override
  $ProviderElement<Settingrepository1> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Settingrepository1 create(Ref ref) {
    return settingrepository1(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Settingrepository1 value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Settingrepository1>(value),
    );
  }
}

String _$settingrepository1Hash() =>
    r'1018584909ecff37deac36b8ae87c94cf12937e4';
