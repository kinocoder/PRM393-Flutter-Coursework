

class CartItem1 {
  const CartItem1({
    required this.product,
    this.quantity = 1,
    this.isSelected = false,
  });

  final String product;
  final int quantity;
  final bool isSelected;

  CartItem1 copyTo({int? quantity, bool? isSelected}) {
    return CartItem1(
      product: product,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  CartItem1 copyWith({int? quantity, bool? isSelected}) => CartItem1(
    product: product,
    quantity: quantity ?? this.quantity,
    isSelected: isSelected ?? this.isSelected,
  );

  factory CartItem1.fromJson(Map<String, dynamic> json) => CartItem1(
    product: json['product'] as String? ?? '',
    quantity: json['quantity'] as int? ?? 1,
    isSelected: json['isSelected'] as bool? ?? false,
  );
}
