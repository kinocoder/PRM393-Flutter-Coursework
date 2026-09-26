import 'package:flutter/material.dart';

class CommonUI extends StatelessWidget {
  const CommonUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug & Fix Common UI Errors")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Correct ListView inside Column using Expanded",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(leading: Icon(Icons.movie), title: Text('Movie A')),
                ListTile(leading: Icon(Icons.movie), title: Text('Movie B')),
                ListTile(leading: Icon(Icons.movie), title: Text('Movie C')),
                ListTile(leading: Icon(Icons.movie), title: Text('Movie D')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
