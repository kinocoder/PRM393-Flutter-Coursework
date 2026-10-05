import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/models/product.dart';
import 'package:hoc_tren_truong/data/repositories/product_repository.dart';

void main() {
  late ProductRepository repository;
  final shirt = Product(
    carId: 'none',
    id: 'p1',
    name: 'Áo thun',
    price: 200000,
  );
  final jeans = Product(
    carId: 'none',
    id: 'p2',
    name: 'Quần jean',
    price: 400000,
  );

  setUp(() => repository = ProductRepository());

  test('Add, read and reject duplicate IDs', () async {
    expect(repository.isEmpty, isTrue);
    await repository.addProduct(shirt);
    expect(repository.productCount, 1);
    expect(await repository.getAllProduct(), [shirt]);
    expect(await repository.getProductByID('p1'), same(shirt));
    expect(await repository.containsProduct('p1'), isTrue);
    expect(await repository.containsProduct('missing'), isFalse);
    await expectLater(repository.addProduct(shirt), throwsStateError);
    await expectLater(repository.getProductByID('missing'), throwsStateError);
    expect(repository.productCount, 1);
  });

  test(
    'Update replaces matching product and preserves other products',
    () async {
      await repository.addProduct(shirt);
      await repository.addProduct(jeans);
      final updated = Product(
        carId: 'none',
        id: 'p1',
        name: 'Áo mới',
        price: 250000,
      );
      await repository.updateProduct(updated);
      expect(await repository.getProductByID('p1'), same(updated));
      expect(await repository.getProductByID('p2'), same(jeans));
      await expectLater(
        repository.updateProduct(
          Product(carId: 'none', id: 'missing', name: 'Không có'),
        ),
        throwsStateError,
      );
      expect(repository.productCount, 2);
    },
  );

  test('Search matches names ignoring case and outer whitespace', () async {
    await repository.addProduct(shirt);
    await repository.addProduct(jeans);
    expect(await repository.searchProducts('  ÁO  '), [shirt]);
    expect(await repository.searchProducts('jean'), [jeans]);
    expect(await repository.searchProducts('không có'), isEmpty);
    expect(await repository.searchProducts('  '), [shirt, jeans]);
    expect(repository.productCount, 2);
  });

  test('Remove by ID and clear all products', () async {
    await repository.addProduct(shirt);
    await repository.addProduct(jeans);
    await repository.removeProduct('p1');
    await repository.removeProduct('missing');
    expect(await repository.getAllProduct(), [jeans]);
    await repository.clearProducts();
    expect(repository.isEmpty, isTrue);
    expect(repository.productCount, 0);
  });
}
