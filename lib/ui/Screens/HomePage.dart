import 'package:flutter/material.dart';
import 'package:hoc_tren_truong/ui/Widgets/BodyWidgets.dart';

import '../Widgets/Lap4Widget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  static const titles = [
    'Giao diện trên lớp',
    'Lab 4 – Flutter UI Fundamentals',
    'Đang cập nhật...',
  ];

  //Thanh công cụ
  Widget build(BuildContext context) {
    return DefaultTabController(length: titles.length, child: Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          final controler = DefaultTabController.of(context);

          return AnimatedBuilder(
            animation: controler, builder: (context, child) {
            return Text(titles[controler.index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },);
        },),
        bottom: const TabBar(tabs: [
          Tab(icon: Icon(Icons.menu_book), text: "Giao diện trên lớp",),
          Tab(
            icon: Icon(Icons.menu_book), text: "Lab 4 - Flutter UI Fundament",),
          Tab(icon: Icon(Icons.lock_clock), text: "Đang cập nhật..",)
        ]),
      ),
      body: TabBarView(children: [
        BodyWidget(),
        LapExercise(),
        const Center(child: Text("Trang hiện nay đang cập nhật"),)
      ]),
    )
    );
  }


}
