import 'package:hoc_tren_truong/data/model/Product.dart';

/// Giả lập database sản phẩm bằng List, chưa kết nối database thật.
/// Mỗi instance có dữ liệu riêng và mất dữ liệu khi khởi động lại ứng dụng.
class ProductReposistories {
  // Danh sách đóng vai trò bảng sản phẩm trong database giả.
  List<Product> products = [];

  ProductReposistories();

  // 1. Đọc và tìm kiếm sản phẩm.

  /// Lấy toàn bộ danh sách sản phẩm.
  Future<List<Product>> getAllProduct() async {
    return products;
  }

  /// Tìm sản phẩm theo ID; báo lỗi nếu không tìm thấy.
  Future<Product> getProductByID(String id) async {
    return products.firstWhere(
      (p) => p.id == id,
      orElse: () => throw StateError('Product with ID $id not found'),
    );
  }

  /// Kiểm tra ID sản phẩm đã tồn tại chưa.
  Future<bool> containsProduct(String id) async {
    return products.any((product) => product.id == id);
  }

  /// Tìm theo một phần tên, không phân biệt chữ hoa/chữ thường.
  /// Bỏ khoảng trắng ở hai đầu từ khóa; từ khóa rỗng trả về tất cả sản phẩm.
  Future<List<Product>> searchProducts(String keyword) async {
    final query = keyword.trim().toLowerCase();
    return products
        .where((product) => product.name.toLowerCase().contains(query))
        .toList();
  }

  // 2. Thêm, cập nhật và xóa sản phẩm.

  /// Thêm sản phẩm mới; không cho phép trùng ID.
  Future<void> addProduct(Product p) async {
    if (products.any((product) => product.id == p.id)) {
      throw StateError('Product with ID ${p.id} already exists');
    }
    products.add(p);
  }

  /// Thay toàn bộ thông tin của sản phẩm có cùng ID bằng dữ liệu mới.
  /// Các trường của Product là final nên thay đối tượng trong danh sách.
  /// Hàm này không đổi ID; báo lỗi nếu sản phẩm chưa tồn tại.
  Future<void> updateProduct(Product p) async {
    final index = products.indexWhere((product) => product.id == p.id);
    if (index == -1) {
      throw StateError('Product with ID ${p.id} not found');
    }
    products[index] = p;
  }

  /// Xóa sản phẩm theo ID; ID không tồn tại thì không làm gì.
  /// Chỉ xóa trong danh sách này, không tự xóa sản phẩm ở giỏ hàng.
  Future<void> removeProduct(String id) async {
    products.removeWhere((product) => product.id == id);
  }

  /// Xóa toàn bộ danh sách sản phẩm trong database giả.
  Future<void> clearProducts() async {
    products.clear();
  }

  // 3. Thống kê cơ bản.

  /// Kiểm tra danh sách sản phẩm đang trống hay không.
  bool get isEmpty => products.isEmpty;

  /// Số loại sản phẩm trong danh sách, không phải tổng số lượng tồn kho.
  int get productCount => products.length;
}
