import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        /*child:Text("Hello every one!",
          style: TextStyle(fontSize:50,fontWeight:FontWeight.bold ,color: Colors.cyan),
        )*/
        Column(
          children: [
            Container(
               width: 500,
               height: 500,
               child: Image.asset('asserts/images/1789480835463_8789316428734258228_g2905689298196080542_c6d63fbdcc49397cda46f6daa14250e6.jpg',
                 fit:BoxFit.fill ,
               )),
            Text('name: Yến '),
            Text('price: 1.000.000VND'),
            Text('description: Hơi báo và rất láo')
          ],
        ),
    
    );
  }
}
