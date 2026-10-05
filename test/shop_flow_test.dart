import 'package:hoc_tren_truong/app/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/app/views/shop_page.dart';
import 'package:hoc_tren_truong/data/repositories/cart_repository.dart';
import 'package:hoc_tren_truong/data/repositories/product_repository.dart';
import 'package:hoc_tren_truong/models/product.dart';

void main() {
  testWidgets('Search, detail, add to cart and update selected total', (
    tester,
  ) async {
    final products = ProductRepository(
      initialProducts: [
        Product(
          id: '1',
          name: 'Test shirt',
          carId: 'clothes',
          price: 100,
          discountPercent: 20,
        ),
        Product(id: '2', name: 'Laptop', carId: 'tech'),
      ],
    );
    final cart = CartRepository();
    await cart.clearCart();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productRepositoryProvider.overrideWithValue(products),
          cartRepositoryProvider.overrideWithValue(cart),
        ],
        child: const MaterialApp(home: ShopPage()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'shirt');
    await tester.pumpAndSettle();
    expect(find.text('Laptop'), findsNothing);
    await tester.tap(find.text('Test shirt'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Add to Cart'));
    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cart').last);
    await tester.pumpAndSettle();
    expect(find.text('Test shirt'), findsOneWidget);
    await tester.tap(find.text('Chọn tất cả'));
    await tester.pumpAndSettle();
    expect(find.text('Tổng tiền đã chọn: 80.00'), findsOneWidget);
    await tester.tap(find.byTooltip('Tăng số lượng'));
    await tester.pumpAndSettle();
    expect(find.text('Tổng tiền đã chọn: 160.00'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
