

import 'package:flutter/material.dart';

class DarkModeWitget extends StatefulWidget {
  const DarkModeWitget({super.key});

  @override
  State<DarkModeWitget> createState() => _DardModeWitgetState();
}



class _DardModeWitgetState extends State<DarkModeWitget> {
  bool isDarkMode = false;

  void onDarkModeChange(bool value){
    setState(() {
      isDarkMode = value;
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return Theme(data: isDarkMode? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Exercise 4 - App Structure & Theme"),
          actions: [
            Center(child: Icon(Icons.dark_mode)),
            Switch(
              value: isDarkMode,
              onChanged: onDarkModeChange,
              ),
          ],
        ),
        body: Center(
          child: Text("This ís the simple screen with theme toggle"),
        ),
      ),
    );
  }
}
