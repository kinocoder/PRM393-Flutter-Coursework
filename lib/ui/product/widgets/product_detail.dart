import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/domain/models/product.dart';
import 'package:hoc_tren_truong/utils/currency_formatter.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    String? imagePath = product.image;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        //ảnh sản phẩm
        Image.network(
          imagePath ?? '',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_outlined,
              size: 48,
              color: Colors.grey,
            );
          },
        ),
        //Nội dung bên dưới ảnh
        //Tên sản phẩm
        const SizedBox(height: 10),
        Text(product.name, style: TextStyle(fontSize: 24)),
        const SizedBox(height: 10),
        Row(
          children: [
            ...List.generate(5, (index) {
              final remaining = product.rating - index;

              return Icon(
                remaining >= 1
                    ? Icons.star
                    : remaining >= 0.5
                    ? Icons.star_half
                    : Icons.star_border,
                color: Colors.amber,
                size: 30,
              );
            }),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                '(${product.rating.toStringAsFixed(1)})'
                ' • ${product.reviewCount} đánh giá',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        //Giá tiền
        Row(
          children: [
            Text(
              formatVnd(product.price),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: 5),
            Text(
              formatVnd(product.salePrice),
              style: const TextStyle(
                fontSize: 23,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
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

        Text(
          product.description ?? 'Chưa có mô tả',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
