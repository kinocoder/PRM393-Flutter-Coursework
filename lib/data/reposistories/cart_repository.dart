import 'package:hoc_tren_truong/data/model/Product.dart';
import 'package:hoc_tren_truong/data/model/cart_item.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'cart_repository.g.dart';

/// Giả lập database bằng List, giống ProductReposistories.
/// Dùng chung một instance giữa các màn hình để giữ cùng một giỏ hàng.
/// Dữ liệu chỉ lưu trong bộ nhớ và mất khi khởi động lại ứng dụng.

@riverpod
CartRepository cartRepository (Ref ref) => CartRepository();

class CartRepository {
  // 1. Danh sách đóng vai trò bảng giỏ hàng trong database giả.
  // Mỗi CartItem chứa sản phẩm, số lượng mua và trạng thái được chọn.
  // Ba dòng mẫu để thử số lượng, giảm giá và chọn sản phẩm.
  // quantity của Product là tồn kho; quantity của CartItem là số lượng mua.
  List<CartItem> cartItems = [
    CartItem(
      product: Product(
        id: 'SP001',
        name: 'Áo thun cotton',
        quantity: 50,
        price: 200000,
        description: 'Áo thun cotton màu trắng',
        discountPercent: 10,
        rating: 4.5,
        reviewCount: 20,
      ),
      quantity: 2,
      isSelected: true,
    ),
    CartItem(
      product: Product(
        id: 'SP002',
        name: 'Quần jean',
        quantity: 30,
        price: 400000,
        description: 'Quần jean xanh dáng suông',
        discountPercent: 0,
        rating: 4.7,
        reviewCount: 15,
      ),
      quantity: 1,
      isSelected: false,
    ),
    CartItem(
      product: Product(
        id: 'SP003',
        name: 'Giày thể thao',
        quantity: 20,
        price: 500000,
        description: 'Giày thể thao nhẹ, màu đen',
        discountPercent: 20,
        rating: 4.8,
        reviewCount: 32,
      ),
      quantity: 1,
      isSelected: true,
    ),
  ];

  CartRepository();

  // 2. Lấy và tìm kiếm dữ liệu.

  /// Trả trực tiếp danh sách, giống getAllProduct của ProductReposistories.
  /// Nên dùng các hàm bên dưới để cập nhật và kiểm tra số lượng hợp lệ.
  Future<List<CartItem>> getAllItems() async {
    return cartItems;
  }

  /// Tìm theo ID sản phẩm; trả null nếu sản phẩm chưa có trong giỏ.
  Future<CartItem?> getItemByProductId(String productId) async {
    for (final item in cartItems) {
      if (item.product.id == productId) {
        return item;
      }
    }
    return null;
  }

  /// Kiểm tra sản phẩm đã có trong giỏ chưa.
  Future<bool> containsProduct(String productId) async {
    return cartItems.any((item) => item.product.id == productId);
  }

  /// Hàm hỗ trợ cập nhật: tìm bằng firstWhere giống repository sản phẩm.
  /// Báo lỗi nếu ID không tồn tại trong giỏ.
  CartItem _requireItem(String productId) {
    return cartItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () =>
          throw StateError('Không tìm thấy sản phẩm $productId trong giỏ'),
    );
  }

  // 3. Thêm, sửa số lượng và xóa sản phẩm.

  /// Thêm sản phẩm mới; nếu trùng ID thì cộng thêm số lượng.
  /// Sản phẩm mới chưa được chọn. Chưa kiểm tra số lượng tồn kho.
  Future<void> addProduct(Product product, {int quantity = 1}) async {
    if (quantity <= 0) {
      throw ArgumentError.value(
        quantity,
        'quantity',
        'Số lượng phải lớn hơn 0',
      );
    }
    if (cartItems.any((item) => item.product.id == product.id)) {
      _requireItem(product.id).quantity += quantity;
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }
  }

  /// Đặt số lượng mới cho sản phẩm đã có: bằng 0 thì xóa, âm thì báo lỗi.
  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity < 0) {
      throw ArgumentError.value(quantity, 'quantity', 'Số lượng không được âm');
    }
    final item = _requireItem(productId);
    if (quantity == 0) {
      cartItems.remove(item);
    } else {
      item.quantity = quantity;
    }
  }

  /// Tăng số lượng thêm 1; báo lỗi nếu sản phẩm chưa có trong giỏ.
  Future<void> increaseQuantity(String productId) async {
    _requireItem(productId).quantity++;
  }

  /// Giảm số lượng đi 1; nếu đang là 1 thì xóa sản phẩm khỏi giỏ.
  /// Báo lỗi nếu sản phẩm chưa có trong giỏ.
  Future<void> decreaseQuantity(String productId) async {
    final item = _requireItem(productId);
    if (item.quantity == 1) {
      cartItems.remove(item);
    } else {
      item.quantity--;
    }
  }

  /// Xóa theo ID sản phẩm; ID không tồn tại thì không làm gì.
  Future<void> removeProduct(String productId) async {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  /// Xóa toàn bộ giỏ hàng.
  Future<void> clearCart() async {
    cartItems.clear();
  }

  // 4. Chọn hoặc bỏ chọn sản phẩm.

  /// Cập nhật trạng thái chọn; báo lỗi nếu ID không tồn tại.
  Future<void> setSelected(String productId, bool isSelected) async {
    _requireItem(productId).isSelected = isSelected;
  }

  /// Đảo trạng thái chọn khi nhấn checkbox; báo lỗi nếu ID không tồn tại.
  Future<void> toggleSelected(String productId) async {
    final item = _requireItem(productId);
    item.isSelected = !item.isSelected;
  }

  /// Chọn tất cả; truyền isSelected: false để bỏ chọn tất cả.
  Future<void> selectAll({bool isSelected = true}) async {
    for (final item in cartItems) {
      item.isSelected = isSelected;
    }
  }

  /// Lấy các sản phẩm được chọn, chưa thực hiện thanh toán.
  Future<List<CartItem>> getSelectedItems() async {
    return cartItems.where((item) => item.isSelected).toList();
  }

  /// Xóa các sản phẩm được chọn, giữ lại sản phẩm chưa chọn.
  Future<void> removeSelectedItems() async {
    cartItems.removeWhere((item) => item.isSelected);
  }

  // 5. Thống kê và tính tiền trực tiếp từ danh sách giả lập.

  /// Kiểm tra giỏ hàng trống.
  bool get isEmpty => cartItems.isEmpty;

  /// Số loại sản phẩm khác nhau trong giỏ.
  int get itemCount => cartItems.length;

  /// Tổng số lượng mua: 2 áo và 3 quần thì kết quả là 5.
  int get totalQuantity {
    int total = 0;
    for (final item in cartItems) {
      total += item.quantity;
    }
    return total;
  }

  /// Tổng số lượng của các sản phẩm được chọn.
  int get selectedQuantity {
    int total = 0;
    for (final item in cartItems) {
      if (item.isSelected) {
        total += item.quantity;
      }
    }
    return total;
  }

  /// Giỏ phải có sản phẩm và tất cả đều được chọn mới trả về true.
  bool get isAllSelected =>
      cartItems.isNotEmpty && cartItems.every((item) => item.isSelected);

  /// Tổng tiền cả giỏ = giá sau giảm nhân số lượng, chưa tính phí vận chuyển.
  double get totalPrice {
    double total = 0;
    for (final item in cartItems) {
      total += item.product.salePrice * item.quantity;
    }
    return total;
  }

  /// Tổng tiền chỉ tính các sản phẩm đang được chọn.
  double get selectedTotalPrice {
    double total = 0;
    for (final item in cartItems) {
      if (item.isSelected) {
        total += item.product.salePrice * item.quantity;
      }
    }
    return total;
  }
}
