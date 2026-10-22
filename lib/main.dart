import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoc_tren_truong/ui/home/widgets/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hoc_tren_truong/firebase_options.dart';
import 'package:hoc_tren_truong/ui/core/theme/view_models/theme_view_model.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ProviderScope giữ trạng thái Riverpod dùng chung cho toàn bộ ứng dụng.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeViewModelProvider);
    final isDarkMode = themeAsync.value ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
