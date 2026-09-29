

import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/ui/Widgets/ProductCardWidget.dart';

import '../../data/model/Product.dart';

class ProductsWidget extends StatefulWidget {
  final ValueChanged<Product> onProductSelected;

  const ProductsWidget({
    super.key,
    required this.onProductSelected,
  });

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  String query= '';

  final List<Product> products = [
    Product(
      id: '1',
      name: 'iPhone 15',
      quantity: 0,
      price: 1099.0,
      discountPercent: 9,
      description: 'Điện thoại iPhone 15 với thiết kế mới và camera cải tiến.',
      image: 'https://shopdidong.vn/wp-content/uploads/2026/06/1-27.webp',
      rating: 4.8,
      reviewCount: 120,
    ),
    Product(
      id: '2',
      name: 'Samsung S24',
      quantity: 0,
      price: 999.0,
      discountPercent: 10,
      description: 'Điện thoại Samsung S24 với màn hình sắc nét.',
      image: 'https://cdn2.fptshop.com.vn/unsafe/512x0/filters:format(webp):quality(75)/2024_1_29_638421471246167545_samsung-galaxy-s24-xam-1.png',
      rating: 4.6,
      reviewCount: 85,
    ),
    Product(
      id: '3',
      name: 'MacBook Air',
      quantity: 0,
      price: 1299.0,
      discountPercent: 8,
      description: 'Laptop MacBook Air mỏng nhẹ, phù hợp học tập và làm việc.',
      image: 'https://apple.ngocnguyen.vn/cdn/images/202304/goods_img/macbook-air-13-inch-2020-i5-11ghz-ram-8gb-ssd-512gb-P7389-1680833827007.jpg',
      rating: 4.9,
      reviewCount: 64,
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product.name.toLowerCase().contains(query);
    }).toList();
    return Column(
      children:[
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (value) {
              setState(() {
                query = value.trim().toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
        child:ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filteredProducts.length,
            itemBuilder: (context,index){
              return ProductCard(product: filteredProducts[index], onTap: () => widget.onProductSelected(filteredProducts[index],));
            }
        ),
      ),]
    );
  }
}
