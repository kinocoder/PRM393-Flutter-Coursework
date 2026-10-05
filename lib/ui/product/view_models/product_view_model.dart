import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hoc_tren_truong/data/repositories/ProductRepository.dart';
import 'package:hoc_tren_truong/domain/models/product.dart';

part 'product_view_model.g.dart';

@riverpod
class ProductViewModel extends _$ProductViewModel {
  @override
  Future<List<Product>> build() async {
    final repository = ref.watch(productrepositoryProvider);
    return repository.getProducts();
  }
}
