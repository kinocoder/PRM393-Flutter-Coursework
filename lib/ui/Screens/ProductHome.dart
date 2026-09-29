import 'package:flutter/material.dart';

import '../../data/model/Product.dart';
import '../Widgets/ListProductWidget.dart';
import '../Widgets/ProductDetail.dart';

class ProductHomeWidget extends StatefulWidget {
  const ProductHomeWidget({super.key});

  @override
  State<ProductHomeWidget> createState() => _ProductHomeWidgetState();
}

class _ProductHomeWidgetState extends State<ProductHomeWidget> {
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
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Đã chọn ${selectedProduct!.name}'),
                      ),
                    );
                  },
                ),
        _ => const Center(child: Text('Giỏ hàng')),
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
