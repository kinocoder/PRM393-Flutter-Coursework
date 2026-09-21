import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/ui/Screens/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  Widget build(BuildContext context){
    return MaterialApp(
      themeMode: ThemeMode.dark,
      home:Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


