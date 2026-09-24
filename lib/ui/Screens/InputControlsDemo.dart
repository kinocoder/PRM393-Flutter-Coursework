import 'package:flutter/material.dart';

class ExeWidget2 extends StatefulWidget {
  const ExeWidget2({super.key});

  @override
  State<ExeWidget2> createState() => _ExeWidget2State();
}



class _ExeWidget2State extends State<ExeWidget2> {
  double sliderValue = 0;
  double sliderConfirmValue = 0;
  bool isActive = false;
  bool actionCheck = false;
  Map<String, bool> movieGenres = {'Action': false, 'Comedy': false};

  void onRatingChange(double value){
    setState(() {
      sliderValue = value;
    });
  }

  void onRatingChangeEnd(double value){
    setState(() {
      sliderConfirmValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercise2 - Input Controls Demo")),
      body: ListView(padding: EdgeInsets.only(left: 7),
        children: [
          const Text(
            "Rating (Slider)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Slider(
              value: sliderValue,
              min: 0,
              max:100,
              divisions: 100,
              label: sliderValue.toStringAsFixed(0),
              onChanged: onRatingChange,
              onChangeEnd: onRatingChangeEnd,
          ),
          Text("Current value: ${sliderValue.toStringAsFixed(0)}",style: TextStyle(fontSize: 20),),

        ],
      ),
    );
  }
}
