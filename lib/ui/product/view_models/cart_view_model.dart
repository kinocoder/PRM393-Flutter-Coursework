import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hoc_tren_truong/data/repositories/CartRepository.dart';
import 'package:hoc_tren_truong/domain/models/cart_item.dart';

part 'cart_view_model.g.dart';

@riverpod
class CartViewModel extends _$CartViewModel {
  @override
  Future<List<CartItem>> build() async {
    final repo = ref.watch(cartRepositoryProvider);
    return repo.getCarts();
  }

  //Cập nhật số lượng
  Future<void> changeQuantity(String productId, int delta) async {
    final repo = ref.read(cartRepositoryProvider);
    final items = await repo.getCarts();

    final index = items.indexWhere(
          (item) => item.product.id == productId,
    );

    if (index == -1) {
      throw StateError('Sản phẩm chưa có trong giỏ hàng');
    }

    final newQuantity = items[index].quantity + delta;

    await repo.updateQuantity(productId, newQuantity);

    // Đưa dữ liệu mới vào state để View hiển thị lại
    state = AsyncData(await repo.getCarts());
  }

  //Phần tích chọn
  Future<void> updateSelection(
      String productId,
      bool isSelected,
      ) async {
    final repo = ref.read(cartRepositoryProvider);

    await repo.updateSelection(productId, isSelected);
    state = AsyncData(await repo.getCarts());
  }

  //Tỉnh tổng hóa đơn
  double get selectedTotal {
    final items = state.asData?.value;

    if (items == null) return 0;

    double total = 0;

    for (final item in items) {
      if (item.isSelected) {
        total += item.product.salePrice * item.quantity;
      }
    }

    return total;
  }

}
