import 'package:flutter/material.dart';

class CoreWidgetDemo extends StatelessWidget {
  const CoreWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 - Core Widgets')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            child: Text(
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              "Welcome to Flutter UI",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            child: const Icon(Icons.movie, size: 120, color: Colors.blue),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            child: Image.network(
              "https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/10_diem_meme_cover_3af8f915a7.png",
            ),
          ),
          Card(margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 16,right: 16),
              leading: Icon(Icons.star,size: 32,),
              title: Text("Movie Item",style: TextStyle(fontSize: 25),),
              subtitle: Text("This is a sample ListTile inside a Card .",style:TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
