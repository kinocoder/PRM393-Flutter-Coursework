import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hoc_tren_truong/domain/models/product.dart';


/// Composition/navigation boundary. Domain actions stay inside feature ViewModels.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ShopPageState();
}

class _ShopPageState extends State<HomeScreen> {
  int selectedIndex = 0;
  final titles = ['Products', 'Product Detail', 'Cart'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(titles[selectedIndex],style: TextStyle(fontSize: 34),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 40,),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline,size: 40,),
            label: 'Product Detail'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,size: 40,),
            label: 'Cart'
          )
        ],
      ),
    );
  }
}
