import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/data/services/shop_data_service.dart';
import 'package:hoc_tren_truong/data/repositories/product_repository.dart';
import 'package:hoc_tren_truong/data/repositories/cart_repository.dart';
import 'package:hoc_tren_truong/models/product.dart';

import '../fakes/fake_shop_data_service.dart';

class BrokenBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      throw StateError('asset unavailable');
}

class InvalidBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(Uint8List.fromList(utf8.encode('{invalid')));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'Real bundled data flows through Service to Repository unchanged',
    () async {
      final service = AssetShopDataService(bundle: rootBundle);
      final products = ProductRepository(service: service);
      final cart = CartRepository(service: service);
      addTearDown(products.dispose);
      addTearDown(cart.dispose);
      expect((await products.getAllProduct()).map((p) => p.name), [
        'iPhone 15',
        'Samsung S24',
        'MacBook Air',
      ]);
      expect((await products.getClassroomProducts()).length, 3);
      expect((await cart.getAllItems()).length, 3);
      expect(cart.selectedTotalPrice, 760000);
      expect(() => products.products.clear(), throwsUnsupportedError);
      expect(() => cart.items.clear(), throwsUnsupportedError);
    },
  );
  test('Asset failures and malformed JSON propagate to caller', () async {
    await expectLater(
      AssetShopDataService(bundle: BrokenBundle()).readCollection('products'),
      throwsStateError,
    );
    await expectLater(
      AssetShopDataService(bundle: InvalidBundle()).readCollection('products'),
      throwsFormatException,
    );
  });
  test(
    'Repository shares concurrent loading, caches and retains local mutations',
    () async {
      final service = FakeShopDataService(
        collections: {
          'products': [Product(id: '1', name: 'One', carId: 'none').toJson()],
        },
      );
      final repository = ProductRepository(service: service);
      addTearDown(repository.dispose);
      await Future.wait([
        repository.getAllProduct(),
        repository.getAllProduct(),
      ]);
      expect(service.calls, 2); // products + classroom, each loaded once.
      await repository.clearProducts();
      expect(await repository.getAllProduct(), isEmpty);
      expect(service.calls, 2);
    },
  );
  test(
    'JSON round trip preserves all product fields and accepts integer numbers',
    () {
      final product = Product.fromJson({
        'id': 'p',
        'name': 'P',
        'price': 50,
        'rating': 4,
        'carId': 'c',
      });
      expect(Product.fromJson(product.toJson()), product);
      expect(product.price, 50.0);
      expect(product.copyTo(image: 'new'), isNot(product));
    },
  );
}
