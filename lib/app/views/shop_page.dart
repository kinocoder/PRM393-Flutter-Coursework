import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';
import '../../features/cart/view/cart_view.dart';
import '../../features/products/view/products_view.dart';
import '../../features/products/view/product_detail_view.dart';

/// Composition/navigation boundary. Domain actions stay inside feature ViewModels.
class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});
  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
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
        0 => ProductsView(
          onProductSelected: (product) => setState(() {
            selectedProduct = product;
            selectedIndex = 1;
          }),
        ),
        1 =>
          selectedProduct == null
              ? const Center(child: Text('Hãy chọn một sản phẩm ở Home'))
              : ProductDetailView(product: selectedProduct!),
        _ => const CartView(),
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 50),
        unselectedIconTheme: const IconThemeData(size: 50),
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
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
