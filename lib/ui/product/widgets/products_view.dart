import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoc_tren_truong/ui/product/view_models/product_view_model.dart';
import 'package:hoc_tren_truong/ui/product/widgets/product_detail.dart';

import '../../../domain/models/product.dart';
import 'product_card.dart';

class ProductsView extends ConsumerWidget {
  final ValueChanged<Product> onProductSelected;
  const ProductsView({super.key, required this.onProductSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Theo dõi danh sách sản phẩm
    final products = ref.watch(productViewModelProvider);
    return products.when(
      //đang lấy dữ liệu
      loading: () => const Center(child: CircularProgressIndicator()),
      //Lấy dữ liệu thất bại
      error: (error, stackTrace) =>
          const Center(child: Text("Không thể tải sản phẩm")),
      //Lấy dữ liệu thành công
      data: (products) {
        if (products.isEmpty) {
          return const Center(child: Text("Chưa có sản phẩm"));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              key: ValueKey(product.id),
              product: product,
              onTap: () => onProductSelected(product),
            );
          },
        );
      },
    );
  }
}
