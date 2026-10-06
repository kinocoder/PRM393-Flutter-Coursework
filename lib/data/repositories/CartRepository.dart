import '../../domain/models/cart_item.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part "CartRepository.g.dart";

@riverpod
Cartrepository cartRepository(Ref ref) {
  return Cartrepository();
}

class Cartrepository {
  final List<CartItem> carts = [];

  //Lấy tất cả phần tử trong giỏ hàng
  Future<List<CartItem>> getCarts() async {
    return List<CartItem>.unmodifiable(carts);
  }

  //

  //Thêm phần tử vào trong giỏ hàng
  Future<void> addCartItem(CartItem cartItem) async {
    carts.add(cartItem);
  }

  //Cập nhật số lượng mới vào phần tử
  Future<void> updateQuantity(String productId, int newQuantity) async {
    final index = carts.indexWhere((item) => item.product.id == productId);
    //Số lượng trong giỏ hàng <1 (tức là không chọn) xóa khỏi giỏ hàng
    if (newQuantity < 1) {
      carts.remove(index);
    }
    //Khai báo Item cũ
    final oldItem = carts[index];
    //So sánh số lượng tồn trong sản phẩm với số lượng đặt mua trong giỏ hàng
    if (oldItem.product.quantity < newQuantity) {
      throw StateError("Số lượng tồn kho không đủ");
    }

    //thay đổi số lượng bằng cách copy ra 1 Item mới với số lượng mới
    carts[index] = oldItem.copyWith(quantity: newQuantity);

    if (index == -1) {
      throw StateError("Sản phẩm chưa có trong giỏ hàng");
    }
  }
}
