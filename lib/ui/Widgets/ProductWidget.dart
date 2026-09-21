import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/data/model/Product.dart';


class _ButtonLikeState extends State<ButtonLike> {
  int x = 0;
  void ChangeLike(){
    setState(() {
      x = x == 0 ? 1 : x == 1 ? 2 : 0;

    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: ChangeLike,
        icon: Icon(x == 2?Icons.safety_check:Icons.star),color: x==0?Colors.grey:Colors.yellow
    );
  }
}

class ButtonLike extends StatefulWidget {
  const ButtonLike({super.key});

  @override
  State<ButtonLike> createState() => _ButtonLikeState();
}



class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 800,
      child: Column(
        //sắp xếp giao diện theo chiều dọc
        children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonLike(),
            ),
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
          Expanded(flex: 2,
            child: SizedBox(
              height: 120,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${product.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Text("Price: "),
                          Text(
                            '${product.price}\$',
                            style: const TextStyle(color: Colors.cyan),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            product.description ?? "",
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
