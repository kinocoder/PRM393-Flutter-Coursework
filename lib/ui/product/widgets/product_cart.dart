import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/domain/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(product.name),
        subtitle: Text('${product.salePrice.toStringAsFixed(0)} VND'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              color: Colors.yellow,
              size: 20,
            ),
            Text('${product.rating}')
          ],
        ),
      ),
    );
  }
}
