import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/app/dependencies.dart';
import 'package:hoc_tren_truong/data/repositories/cart_repository.dart';
import 'package:hoc_tren_truong/features/cart/viewmodel/cart_view_model.dart';
import 'package:hoc_tren_truong/features/products/viewmodel/product_detail_view_model.dart';
import 'package:hoc_tren_truong/models/product.dart';

class DelayedCartRepository extends CartRepository {
  final started = Completer<void>();
  final gate = Completer<void>();
  int calls = 0;
  @override
  Future<void> addProduct(Product product, {int quantity = 1}) async {
    calls++;
    if (!started.isCompleted) started.complete();
    await gate.future;
    await super.addProduct(product, quantity: quantity);
  }
}

void main() {
  final product = Product(
    id: 'p1',
    name: 'Shirt',
    carId: 'clothes',
    price: 100,
    discountPercent: 20,
  );

  test(
    'Detail publishes to shared cart and both consumers observe the change',
    () async {
      final repository = CartRepository();
      final container = ProviderContainer(
        overrides: [cartRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(() {
        container.dispose();
        repository.dispose();
      });
      var firstQuantity = 0;
      var secondQuantity = 0;
      container.listen(cartViewModelProvider, (_, next) {
        firstQuantity =
            next.asData?.value.data.items.fold<int>(
              0,
              (sum, i) => sum + i.quantity,
            ) ??
            0;
      });
      container.listen(cartViewModelProvider, (_, next) {
        secondQuantity =
            next.asData?.value.data.items.fold<int>(
              0,
              (sum, i) => sum + i.quantity,
            ) ??
            0;
      });
      await container.read(cartViewModelProvider.future);
      final vm = container.read(cartViewModelProvider.notifier);
      final detailProvider = productDetailViewModelProvider(product);
      container.listen(detailProvider, (_, next) {});
      await container.read(detailProvider.notifier).addToCart();
      expect(container.read(detailProvider).requireValue, isTrue);
      expect(firstQuantity, 1);
      expect(secondQuantity, 1);
      final before = container.read(cartViewModelProvider).requireValue.data;
      await vm.setSelected('p1', true);
      await vm.increaseQuantity('p1');
      expect(
        container
            .read(cartViewModelProvider)
            .requireValue
            .data
            .selectedTotalPrice,
        160,
      );
      expect(before.items.single.quantity, 1);
      expect(before.items.single.isSelected, isFalse);
      expect(await vm.updateQuantity('p1', -1), isFalse);
      final failed = container.read(cartViewModelProvider).requireValue;
      expect(failed.actionError, isA<ArgumentError>());
      expect(failed.data.selectedTotalPrice, 160);
      await vm.decreaseQuantity('p1');
      expect(
        container.read(cartViewModelProvider).requireValue.actionError,
        isNull,
      );
      await vm.removeSelectedItems();
      expect(
        container.read(cartViewModelProvider).requireValue.data.items,
        isEmpty,
      );
    },
  );

  test(
    'Invalidation retains shared repository but scopes stay independent',
    () async {
      final repository = CartRepository();
      final container = ProviderContainer(
        overrides: [cartRepositoryProvider.overrideWithValue(repository)],
      );
      final otherRepository = CartRepository();
      final other = ProviderContainer(
        overrides: [cartRepositoryProvider.overrideWithValue(otherRepository)],
      );
      addTearDown(() {
        container.dispose();
        other.dispose();
        repository.dispose();
        otherRepository.dispose();
      });
      await container.read(cartViewModelProvider.future);
      await container.read(cartViewModelProvider.notifier).addProduct(product);
      container.invalidate(cartViewModelProvider);
      expect(
        (await container.read(cartViewModelProvider.future))
            .data
            .items
            .single
            .product,
        product,
      );
      expect(
        (await other.read(cartViewModelProvider.future)).data.items,
        isEmpty,
      );
    },
  );

  test('Mutation guards duplicates and exposes busy; completion after dispose is safe', () async {
    final repository = DelayedCartRepository();
    final container = ProviderContainer(
      overrides: [cartRepositoryProvider.overrideWithValue(repository)],
    );
    await container.read(cartViewModelProvider.future);
    final vm = container.read(cartViewModelProvider.notifier);
    final pending = vm.addProduct(product);
    await repository.started.future;
    expect(container.read(cartViewModelProvider).requireValue.isBusy, isTrue);
    expect(await vm.addProduct(product), isFalse);
    expect(repository.calls, 1);
    container.dispose();
    repository.gate.complete();
    expect(await pending, isFalse);
    repository.dispose();
  });

  test('Old mutation cannot overwrite rebuilt provider state', () async {
    final repository = DelayedCartRepository();
    final container = ProviderContainer(
      overrides: [cartRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(() {
      container.dispose();
      repository.dispose();
    });
    await container.read(cartViewModelProvider.future);
    final pending = container
        .read(cartViewModelProvider.notifier)
        .addProduct(product);
    await repository.started.future;
    container.invalidate(cartViewModelProvider);
    await container.read(cartViewModelProvider.future);
    repository.gate.complete();
    expect(await pending, isFalse);
    final current = container.read(cartViewModelProvider).requireValue;
    expect(current.isBusy, isFalse);
    // The repository mutation still completes and legitimately notifies the new build.
    expect(current.data.items.single.product, product);
  });
}
