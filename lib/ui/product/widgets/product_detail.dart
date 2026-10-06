
import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/domain/models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;


  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    String? imagePath = product.image;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        //ảnh sản phẩm
        Image.network(
          imagePath ?? '',
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_outlined,
              size: 48,
              color: Colors.grey,
            );
          },
        ),
        //Nội dung bên dưới ảnh
        const SizedBox(height: 16),
        Text(product.name,style: TextStyle(fontSize: 24),),
        const SizedBox(height: 16,),
        Row(
          children: [

          ],
        ),
      ],
    );
  }
}
