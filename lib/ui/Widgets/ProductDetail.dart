import 'package:flutter/material.dart';
import '../../data/model/Product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductDetail({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = product.image;
    final hasDiscount = product.discountPercent > 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Ảnh sản phẩm lớn
          Container(
            width: double.infinity,
            height: 270,
            color: const Color(0xFFF5F5F7),
            padding: const EdgeInsets.all(20),
            child: imagePath != null && imagePath.isNotEmpty
                ? Image.network(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 80,
                  color: Colors.grey,
                );
              },
            )
                : const Icon(
              Icons.image_not_supported,
              size: 80,
              color: Colors.grey,
            ),
          ),

          // 2. Thông tin bên dưới ảnh
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Sao + điểm đánh giá + số lượt đánh giá
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      final starNumber = index + 1;

                      IconData icon;
                      if (product.rating >= starNumber) {
                        icon = Icons.star;
                      } else if (product.rating >= starNumber - 0.5) {
                        icon = Icons.star_half;
                      } else {
                        icon = Icons.star_border;
                      }

                      return Icon(
                        icon,
                        color: Colors.orange,
                        size: 22,
                      );
                    }),
                    const SizedBox(width: 8),
                    Text(
                      '(${product.rating.toStringAsFixed(1)})'
                          ' · ${product.reviewCount} reviews',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Giá gốc, giá sau giảm và nhãn %
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    if (hasDiscount)
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Text(
                      '\$${product.salePrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: hasDiscount ? Colors.red : Colors.black,
                      ),
                    ),
                    if (hasDiscount)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '-${product.discountPercent}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Mô tả
                Text(
                  product.description?.isNotEmpty == true
                      ? product.description!
                      : 'No description available.',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                // Nút Add to Cart
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}