import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/ui/Widgets/BodyWidgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text("Home Page"),
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.search))],
      ),
      body: BodyWidget()
    );
  }
}
