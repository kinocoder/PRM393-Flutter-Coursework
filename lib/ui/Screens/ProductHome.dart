import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/shop_providers.dart';
import '../Widgets/cart_widget.dart';

import '../../data/model/Product.dart';
import '../Widgets/ListProductWidget.dart';
import '../Widgets/ProductDetail.dart';

class ProductHomeWidget extends ConsumerStatefulWidget {
  const ProductHomeWidget({super.key});

  @override
  ConsumerState<ProductHomeWidget> createState() => _ProductHomeWidgetState();
}

class _ProductHomeWidgetState extends ConsumerState<ProductHomeWidget> {
  Product? selectedProduct;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final titles = ['Products', 'Product Detail', 'Cart'];

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(titles[selectedIndex]),
      ),
      body: switch (selectedIndex) {
        0 => ProductsWidget(
          onProductSelected: (product) {
            setState(() {
              selectedProduct = product;
              selectedIndex = 1;
            });
          },
        ),
        1 =>
          selectedProduct == null
              ? const Center(child: Text('Hãy chọn một sản phẩm ở Home'))
              : ProductDetail(
                  product: selectedProduct!,
                  onAddToCart: () async {
                    final product = selectedProduct!;
                    try {
                      await ref.read(cartActionsProvider).addProduct(product);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đã thêm ${product.name} vào giỏ'),
                        ),
                      );
                    } catch (error) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Không thể thêm sản phẩm: $error'),
                        ),
                      );
                    }
                  },
                ),
        _ => const CartWidget(),
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 50),
        unselectedIconTheme: const IconThemeData(size: 50),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Product Detail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
