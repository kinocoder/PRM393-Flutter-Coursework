import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/app/dependencies.dart';
import 'package:hoc_tren_truong/models/product.dart';
import 'package:hoc_tren_truong/features/products/viewmodel/products_view_model.dart';
import 'package:hoc_tren_truong/features/products/view/products_view.dart';

import '../../fakes/fake_shop_data_service.dart';

class DelayedService extends FakeShopDataService {
  final gate = Completer<void>();
  @override
  Future<List<Map<String, dynamic>>> readCollection(String name) async {
    await gate.future;
    return super.readCollection(name);
  }
}

void main() {
  testWidgets(
    'ref.watch renders loading, error, retry, empty and repository updates',
    (tester) async {
      final service = DelayedService()..failure = StateError('offline');
      final container = ProviderContainer(
        overrides: [shopDataServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(body: ProductsView(onProductSelected: (_) {})),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      service.gate.complete();
      await tester.pumpAndSettle();
      expect(find.text('Không tải được sản phẩm. Thử lại'), findsOneWidget);
      service.failure = null;
      await tester.tap(find.text('Không tải được sản phẩm. Thử lại'));
      await tester.pumpAndSettle();
      expect(find.text('Không có sản phẩm'), findsOneWidget);
      await container
          .read(productRepositoryProvider)
          .addProduct(Product(id: '1', name: 'Demo', carId: 'none'));
      await tester.pumpAndSettle();
      expect(find.text('Demo'), findsOneWidget);
      expect(
        container
            .read(productsViewModelProvider)
            .requireValue
            .data
            .products
            .length,
        1,
      );
    },
  );
}
