import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/Product.dart';
import '../../providers/shop_providers.dart';
import 'ProductCardWidget.dart';

class ProductsWidget extends ConsumerStatefulWidget {
  final ValueChanged<Product> onProductSelected;
  const ProductsWidget({super.key, required this.onProductSelected});

  @override
  ConsumerState<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends ConsumerState<ProductsWidget> {
  // Từ khóa chỉ dùng trong widget nên vẫn giữ bằng setState.
  String query = '';

  @override
  Widget build(BuildContext context) {
    // watch tự xây dựng lại giao diện khi danh sách sản phẩm thay đổi.
    final products = ref.watch(productsProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (value) =>
                setState(() => query = value.trim().toLowerCase()),
            decoration: const InputDecoration(
              hintText: 'Search products...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: products.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: TextButton(
                onPressed: () => ref.invalidate(productsProvider),
                child: const Text('Không tải được sản phẩm. Thử lại'),
              ),
            ),
            data: (items) {
              final filtered = items
                  .where((p) => p.name.toLowerCase().contains(query))
                  .toList();
              if (filtered.isEmpty) {
                return const Center(child: Text('Không có sản phẩm'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (context, index) => ProductCard(
                  product: filtered[index],
                  onTap: () => widget.onProductSelected(filtered[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
