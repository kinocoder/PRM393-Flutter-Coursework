import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/data/model/Product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      child: Column(
        //sắp xếp giao diện theo chiều dọc
        children: [
          Expanded(
            flex: 2,
            child: Container(width: 300,
              child: Stack(
                children: [
                  Container(
                    child: Image.asset(
                      product.image ?? "không có ảnh đâu!",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  //button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      color: Colors.white,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Ảnh của sản phẩm
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${product.name}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Price: "),
                        Text(
                          '${product.price}\$',
                          style: TextStyle(color: Colors.cyan),
                        ),
                        Text(
                          '${product.price * 0.9.round()}\$',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Text(
                          textAlign: TextAlign.justify,
                          product.description ?? "",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
