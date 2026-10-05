import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/models/product.dart';
import 'package:hoc_tren_truong/data/repositories/cart_repository.dart';

void main() {
  late CartRepository cart;
  final product = Product(
    carId: 'none',
    id: 'p1',
    name: 'One',
    price: 100,
    discountPercent: 20,
  );
  final second = Product(carId: 'none', id: 'p2', name: 'Two', price: 50);

  setUp(() async {
    cart = CartRepository();
    await cart.clearCart();
  });

  test('Empty cart has zero totals and no selection', () async {
    expect(cart.isEmpty, isTrue);
    expect(cart.itemCount, 0);
    expect(cart.totalQuantity, 0);
    expect(cart.totalPrice, 0);
    expect(cart.selectedTotalPrice, 0);
    expect(cart.isAllSelected, isFalse);
    expect(await cart.getItemByProductId('missing'), isNull);
  });

  test('Adding the same ID merges quantities and uses sale prices', () async {
    await cart.addProduct(product, quantity: 2);
    await cart.addProduct(product);
    await cart.addProduct(second);
    expect(cart.itemCount, 2);
    expect(cart.totalQuantity, 4);
    expect(cart.totalPrice, 290);
    expect(await cart.containsProduct('p1'), isTrue);
    expect((await cart.getItemByProductId('p1'))!.quantity, 3);
  });

  test('Quantity updates and decrement to zero remove items', () async {
    await cart.addProduct(product);
    await cart.increaseQuantity('p1');
    expect(cart.totalQuantity, 2);
    await cart.decreaseQuantity('p1');
    expect(cart.totalQuantity, 1);
    await cart.decreaseQuantity('p1');
    expect(cart.isEmpty, isTrue);
    await cart.addProduct(product);
    await cart.updateQuantity('p1', 5);
    expect(cart.totalQuantity, 5);
    await cart.updateQuantity('p1', 0);
    expect(cart.isEmpty, isTrue);
  });

  test(
    'Invalid quantities and unknown update IDs fail without mutation',
    () async {
      await expectLater(
        cart.addProduct(product, quantity: 0),
        throwsArgumentError,
      );
      await expectLater(
        cart.addProduct(product, quantity: -1),
        throwsArgumentError,
      );
      await cart.addProduct(product);
      await expectLater(cart.updateQuantity('p1', -1), throwsArgumentError);
      await expectLater(cart.updateQuantity('missing', 1), throwsStateError);
      await expectLater(cart.increaseQuantity('missing'), throwsStateError);
      await expectLater(cart.decreaseQuantity('missing'), throwsStateError);
      await expectLater(cart.setSelected('missing', true), throwsStateError);
      await expectLater(cart.toggleSelected('missing'), throwsStateError);
      expect(cart.totalQuantity, 1);
    },
  );

  test('Selection totals, select all, deselect and remove selected', () async {
    await cart.addProduct(product, quantity: 2);
    await cart.addProduct(second);
    expect(cart.selectedQuantity, 0);
    await cart.setSelected('p1', true);
    expect(cart.selectedQuantity, 2);
    expect(cart.selectedTotalPrice, 160);
    expect(await cart.getSelectedItems(), hasLength(1));
    await cart.toggleSelected('p2');
    expect(cart.isAllSelected, isTrue);
    await cart.selectAll(isSelected: false);
    expect(cart.selectedTotalPrice, 0);
    await cart.selectAll();
    expect(cart.selectedTotalPrice, 210);
    await cart.setSelected('p2', false);
    await cart.removeSelectedItems();
    expect(await cart.containsProduct('p1'), isFalse);
    expect(await cart.containsProduct('p2'), isTrue);
  });

  test('Each repository instance has its own in-memory cart', () async {
    final otherCart = CartRepository();
    await otherCart.clearCart();
    await cart.addProduct(product, quantity: 2);
    await otherCart.addProduct(second);
    await cart.clearCart();
    expect(cart.isEmpty, isTrue);
    expect(otherCart.itemCount, 1);
    expect(otherCart.totalPrice, 50);
    expect(await otherCart.containsProduct('p1'), isFalse);
    expect(await otherCart.containsProduct('p2'), isTrue);
  });
  test('Removal is idempotent and clearing resets totals', () async {
    await cart.addProduct(product);
    await cart.removeProduct('p1');
    await cart.removeProduct('p1');
    expect(cart.isEmpty, isTrue);
    await cart.addProduct(second);
    await cart.selectAll();
    await cart.clearCart();
    expect(await cart.getAllItems(), isEmpty);
    expect(cart.totalPrice, 0);
    expect(cart.selectedQuantity, 0);
    expect(cart.isAllSelected, isFalse);
  });
}
