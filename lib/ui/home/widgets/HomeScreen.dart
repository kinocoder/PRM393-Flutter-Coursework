import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/ui/product/widgets/product_detail.dart';
import 'package:hoc_tren_truong/ui/product/widgets/products_view.dart';
import '../../../domain/models/product.dart';
import 'package:hoc_tren_truong/ui/product/widgets/cart_view.dart';

/// Composition/navigation boundary. Domain actions stay inside feature ViewModels.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ShopPageState();
}

class _ShopPageState extends State<HomeScreen> {
  int selectedIndex = 0;
  final titles = ['Products', 'Product Detail', 'Cart'];
  Product? selectedProduct;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: switch (selectedIndex) {
        0 => ProductsView(
          onProductSelected: (product){
            setState(() {
              selectedProduct = product;
              selectedIndex = 1;
            });
          },
        ),
        1 => selectedProduct == null ? Center(
          child: Text("Hãy chọn 1 sản phẩm ở danh sách",style: TextStyle(fontSize: 25),),
        ) : ProductDetail(product: selectedProduct!),
        _ => const CartView(),
      },
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline, size: 40),
            label: 'Product Detail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 40),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
