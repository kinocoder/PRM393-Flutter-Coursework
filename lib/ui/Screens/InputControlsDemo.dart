import 'package:flutter/material.dart';

class ExeWidget2 extends StatelessWidget {
  const ExeWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercise 2 - Input Controls"),),
      body: ListView(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),"Rating (Slider)"),
              )
            ],
          )
        ],
      ),
    );
  }
}
