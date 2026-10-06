// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CartViewModel)
final cartViewModelProvider = CartViewModelProvider._();

final class CartViewModelProvider
    extends $AsyncNotifierProvider<CartViewModel, List<CartItem>> {
  CartViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartViewModelHash();

  @$internal
  @override
  CartViewModel create() => CartViewModel();
}

String _$cartViewModelHash() => r'6930cab1e8b1009a891aed51803f51c5c0b54c09';

abstract class _$CartViewModel extends $AsyncNotifier<List<CartItem>> {
  FutureOr<List<CartItem>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<CartItem>>, List<CartItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CartItem>>, List<CartItem>>,
              AsyncValue<List<CartItem>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
