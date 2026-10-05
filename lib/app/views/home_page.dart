import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hoc_tren_truong/features/classroom/view/classroom_view.dart';

import 'package:hoc_tren_truong/features/ui_exercises/view/exercises_view.dart';
import 'package:hoc_tren_truong/app/views/shop_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const titles = [
    'Giao diện trên lớp',
    'Lab 4 – Flutter UI Fundamentals',
    'Đang cập nhật...',
  ];

  //Thanh công cụ
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: titles.length,
      child: Scaffold(
        appBar: AppBar(
          title: Builder(
            builder: (context) {
              final controler = DefaultTabController.of(context);

              return AnimatedBuilder(
                animation: controler,
                builder: (context, child) {
                  return Text(
                    titles[controler.index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              );
            },
          ),
          bottom: TabBar(
            onTap: (index) {
              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ShopPage()),
                );
              }
            },
            tabs: [
              Tab(icon: Icon(Icons.menu_book), text: "Giao diện trên lớp"),
              Tab(
                icon: Icon(Icons.menu_book),
                text: "Lab 4 - Flutter UI Fundament",
              ),
              Tab(icon: Icon(Icons.lock_clock), text: "Đang cập nhật.."),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ClassroomView(),
            ExercisesView(),
            const Center(child: Text('Chọn tab để mở sản phẩm')),
          ],
        ),
      ),
    );
  }
}
