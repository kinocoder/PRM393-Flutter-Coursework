// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductViewModel)
final productViewModelProvider = ProductViewModelProvider._();

final class ProductViewModelProvider
    extends $AsyncNotifierProvider<ProductViewModel, List<Product>> {
  ProductViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productViewModelHash();

  @$internal
  @override
  ProductViewModel create() => ProductViewModel();
}

String _$productViewModelHash() => r'242f28ea2cd5d389bcde7276d4f747183b063c71';

abstract class _$ProductViewModel extends $AsyncNotifier<List<Product>> {
  FutureOr<List<Product>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Product>>, List<Product>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Product>>, List<Product>>,
              AsyncValue<List<Product>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
