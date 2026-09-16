import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        /*child:Text("Hello every one!",
          style: TextStyle(fontSize:50,fontWeight:FontWeight.bold ,color: Colors.cyan),
        )*/
        child: RichText(
          text: TextSpan(
            text: "Xin chào",
            style: TextStyle(color: Colors.greenAccent),
            children:<TextSpan> [
              TextSpan(
                text: "Tất cả mọi người",
                style: TextStyle(color: Colors.amberAccent),
              )
            ]
          ),
        ),
    )
    );
  }
}
