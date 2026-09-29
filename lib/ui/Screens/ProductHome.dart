




import 'package:flutter/material.dart';

import '../Widgets/ListProductWidget.dart';

class ProductHomeWidget extends StatefulWidget {
  const ProductHomeWidget({super.key});

  @override
  State<ProductHomeWidget> createState() => _ProductHomeWidgetState();
}

class _ProductHomeWidgetState extends State<ProductHomeWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ProductsWidget(),// Vị trí 0
      const Center(child: Text('Chi tiết')),  // Vị trí 1
      const Center(child: Text('Giỏ hàng')),  // Vị trí 2
    ];

    final titles = ['Products', 'Product Detail', 'Cart'];

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(titles[selectedIndex]),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(size: 50),
        unselectedIconTheme: const IconThemeData(size: 50),
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Product Detail'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart'
          )
        ],
      ),
    );
  }
}

