import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoc_tren_truong/ui/Screens/HomePage.dart';

void main() {
  // ProviderScope giữ trạng thái Riverpod dùng chung cho toàn bộ ứng dụng.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      themeMode: ThemeMode.dark,
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
