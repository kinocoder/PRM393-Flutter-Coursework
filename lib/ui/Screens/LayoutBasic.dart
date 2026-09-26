
import 'package:flutter/material.dart';

class LayoutBasicDemo extends StatelessWidget {
  final movies = ['Avatar','Inception','Interstellar','Joker'];
   LayoutBasicDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Exercise 3 - Layout Demo")),
        body: Column(
          children: [
            Center(
              child: Expanded(flex:2,
                  child: Text("Now Playing",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))
              ),
            ),
            Expanded(
                child:ListView.builder(
                  padding: const EdgeInsets.all(5),
                  itemCount: movies.length,
                  itemBuilder: (context,index){
                    final movie = movies[index];
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(child: Text(movie[0],style: TextStyle(fontSize: 20),),),
                        title: Text(movie,style: TextStyle(fontSize: 20),),
                        subtitle: Text("Sample description",style: TextStyle(fontSize: 17),),
                      ),
                    );
                  },
                )
            )
          ],
        ),
    );
  }
}
