import 'product.dart';

class CartItem {
  const CartItem({
    required this.product,
    this.quantity = 1,
    this.isSelected = false,
  });
  final Product product;
  final int quantity;
  final bool isSelected;

  CartItem copyWith({int? quantity, bool? isSelected}) => CartItem(
    product: product,
    quantity: quantity ?? this.quantity,
    isSelected: isSelected ?? this.isSelected,
  );

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    product: Product.fromJson(
      Map<String, dynamic>.from(json['product'] as Map),
    ),
    quantity: json['quantity'] as int? ?? 1,
    isSelected: json['isSelected'] as bool? ?? false,
  );
}
