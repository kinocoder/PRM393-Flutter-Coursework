import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/domain/models/cart_item.dart';
import 'package:hoc_tren_truong/utils/currency_formatter.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final ValueChanged<bool> onSelected;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final imagePath = product.image;

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: item.isSelected,
                  onChanged: (value) {
                    if (value != null) {
                      onSelected(value);
                    }
                  },
                ),
                SizedBox(
                  width: 70,
                  height: 80,
                  child: imagePath == null || imagePath.isEmpty
                      ? const Icon(
                    Icons.image_outlined,
                    color: Colors.grey,
                    size: 40,
                  )
                      : Image.network(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_outlined,
                        color: Colors.grey,
                        size: 40,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatVnd(product.salePrice),
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Xóa khỏi giỏ',
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onDecrease,
                  tooltip: 'Giảm số lượng',
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '${item.quantity}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: item.quantity < product.quantity
                      ? onIncrease
                      : null,
                  tooltip: 'Tăng số lượng',
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Thành tiền: '
                    '${formatVnd(product.salePrice * item.quantity)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}