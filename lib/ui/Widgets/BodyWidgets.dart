import 'package:flutter/material.dart';

import '../../data/model/Product.dart';
import 'ProductWidget.dart';

class BodyWidget extends StatelessWidget {
  BodyWidget({super.key});

  List<Product> products = [
    Product(
      id: 'SP002',
      name: 'Trí Linh',
      image: 'asserts/images/ten_anh.jpg',
      description: 'Mô tả sản phẩm thứ hai',
      quantity: 2,
      price: 50,
    ),
    Product(
      id: "SP001",
      name: "Yến",
      image: "asserts/images/1789480835463_8789316428734258228_g2905689298196080542_c6d63fbdcc49397cda46f6daa14250e6.jpg",
      description: "Hơi mát mát nên cần cảnh giác",
      quantity: 1,
      price: 100,
    ),
    Product(
      id: 'SP003',
      name: 'Đình thanh',
      image: 'asserts/images/ten_anh.jpg',
      description: 'Mô tả sản phẩm thứ hai',
      quantity: 1,
      price: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2,
      children: products.map((p)=> ProductPage(product: p)).toList(),
    );
  }
}
