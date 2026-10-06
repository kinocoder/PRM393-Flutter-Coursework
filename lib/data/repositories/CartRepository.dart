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

  //Thêm phần tử vào trong giỏ hàng
  Future<void> addCartItem(CartItem cartItem) async {
    if (cartItem.quantity < 1) {
      throw ArgumentError('Số lượng thêm phải lớn hơn hoặc bằng 1');
    }

    final index = carts.indexWhere(
      (item) => item.product.id == cartItem.product.id,
    );

    if (index != -1) {
      await updateQuantity(cartItem.product.id, carts[index].quantity + 1);
      return;
    }

    // Chưa có trong giỏ: kiểm tra còn hàng
    if (cartItem.product.quantity < 1) {
      throw StateError('Sản phẩm đã hết hàng');
    }

    // Thêm dòng mới với số lượng 1
    carts.add(cartItem.copyWith(quantity: 1));
  }

  //Cập nhật số lượng mới vào phần tử
  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (newQuantity < 0) {
      throw ArgumentError('Số lượng không được âm');
    }

    final index = carts.indexWhere((item) => item.product.id == productId);

    //Kiểm tra xem có tồn tại hay không
    if (index == -1) {
      throw StateError("Sản phẩm chưa có trong giỏ hàng");
    }
    //Số lượng trong giỏ hàng <1 (tức là không chọn) xóa khỏi giỏ hàng
    if (newQuantity < 1) {
      carts.removeAt(index);
      return;
    }
    //Khai báo Item cũ
    final oldItem = carts[index];
    //So sánh số lượng tồn trong sản phẩm với số lượng đặt mua trong giỏ hàng
    if (oldItem.product.quantity < newQuantity) {
      throw StateError("Số lượng tồn kho không đủ");
    }

    //thay đổi số lượng bằng cách copy ra 1 Item mới với số lượng mới
    carts[index] = oldItem.copyWith(quantity: newQuantity);
  }
}
