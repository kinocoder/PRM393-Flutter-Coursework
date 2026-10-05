import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/app/dependencies.dart';
import 'package:hoc_tren_truong/data/repositories/product_repository.dart';
import 'package:hoc_tren_truong/models/product.dart';
import 'package:hoc_tren_truong/features/products/viewmodel/products_view_model.dart';

import '../../fakes/fake_shop_data_service.dart';

void main() {
  test(
    'Search and mutations emit immutable Riverpod state and preserve query',
    () async {
      final repository = ProductRepository();
      final container = ProviderContainer(
        overrides: [productRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(() {
        container.dispose();
        repository.dispose();
      });
      var notifications = 0;
      container.listen(productsViewModelProvider, (_, next) => notifications++);
      await container.read(productsViewModelProvider.future);
      final vm = container.read(productsViewModelProvider.notifier);
      final shirt = Product(id: '1', name: 'Áo thun', carId: 'clothes');
      await vm.addProduct(shirt);
      final before = container
          .read(productsViewModelProvider)
          .requireValue
          .data;
      vm.search('  ÁO  ');
      await vm.addProduct(Product(id: '2', name: 'Laptop', carId: 'tech'));
      expect(before.products, [shirt]);
      expect(
        container
            .read(productsViewModelProvider)
            .requireValue
            .data
            .filteredProducts,
        [shirt],
      );
      await vm.updateProduct(shirt.copyTo(name: 'Áo mới'));
      expect(
        container
            .read(productsViewModelProvider)
            .requireValue
            .data
            .filteredProducts
            .single
            .name,
        'Áo mới',
      );
      expect(await vm.addProduct(shirt), isFalse);
      expect(
        container.read(productsViewModelProvider).requireValue.actionError,
        isA<StateError>(),
      );
      expect(
        container
            .read(productsViewModelProvider)
            .requireValue
            .data
            .products
            .length,
        2,
      );
      await vm.removeProduct('1');
      expect(
        container
            .read(productsViewModelProvider)
            .requireValue
            .data
            .filteredProducts,
        isEmpty,
      );
      await vm.clearProducts();
      expect(
        container.read(productsViewModelProvider).requireValue.actionError,
        isNull,
      );
      expect(() => before.products.clear(), throwsUnsupportedError);
      expect(notifications, greaterThan(5));
    },
  );

  test('Load exposes loading/error and can retry via invalidation', () async {
    final service = FakeShopDataService()..failure = StateError('offline');
    final container = ProviderContainer(
      overrides: [shopDataServiceProvider.overrideWithValue(service)],
    );
    addTearDown(container.dispose);
    expect(container.read(productsViewModelProvider).isLoading, isTrue);
    await expectLater(
      container.read(productsViewModelProvider.future),
      throwsStateError,
    );
    expect(container.read(productsViewModelProvider).hasError, isTrue);
    service.failure = null;
    container.invalidate(productsViewModelProvider);
    final result = await container.read(productsViewModelProvider.future);
    expect(result.data.products, isEmpty);
  });
}
