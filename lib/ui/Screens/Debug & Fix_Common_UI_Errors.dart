import 'package:flutter/material.dart';

class CommonUI extends StatefulWidget {
  const CommonUI({super.key});

  @override
  State<CommonUI> createState() => _CommonUIState();
}

class _CommonUIState extends State<CommonUI> {
  int count = 0;

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

          Text('Số lần bấm: $count', style: const TextStyle(fontSize: 28)),
          ElevatedButton(
            onPressed: () {
              count++; // Cố tình gây lỗi: thiếu setState()
              debugPrint('count = $count');
            },
            child: const Text('Tăng'),
          ),
        ],
      ),
    );
  }
}
