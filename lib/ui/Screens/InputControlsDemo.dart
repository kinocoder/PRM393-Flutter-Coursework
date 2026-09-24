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
  String? selectedGenre;
  DateTime? selectedDate;

  void onRatingChange(double value) {
    setState(() {
      sliderValue = value;
    });
  }

  void onRatingChangeEnd(double value) {
    setState(() {
      sliderConfirmValue = value;
    });
  }

  void isActiveChange(bool value) {
    setState(() {
      isActive = value;
    });
  }

  void onGenreChange(String? value){
    setState(() {
      selectedGenre = value;
    });
  }

  Future<void> openDatePicker() async{
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));

    if(pickedDate != null){
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercise2 - Input Controls Demo")),
      body: ListView(
        padding: EdgeInsets.only(left: 7,right: 7),
        children: [
          const Text(
            "Rating (Slider)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Slider(
            value: sliderValue,
            min: 0,
            max: 100,
            divisions: 100,
            label: sliderValue.toStringAsFixed(0),
            onChanged: onRatingChange,
            onChangeEnd: onRatingChangeEnd,
          ),
          Text(
            "Current value: ${sliderValue.toStringAsFixed(0)}",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 25),
          const Text(
            "Active (Switch)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    "Is movie active?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Switch(
                  value: isActive,
                  onChanged: isActiveChange,
                  activeThumbColor: Colors.white,
                  activeTrackColor: Colors.cyan,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            "Genre (RadioListTile)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          RadioGroup(
              groupValue:selectedGenre,
              onChanged: onGenreChange, 
              child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile<String>(
                    value:'Action',
                    toggleable: true,
                    title: Text('Action',style: TextStyle(fontSize: 20),),
                  ),
                  RadioListTile<String>(
                    value:'Comedy',
                    toggleable: true,
                    title: Text('Comedy',style: TextStyle(fontSize: 20),),
                  ),
                  Text('Selected genre: ${selectedGenre?? 'None'}',style: TextStyle(fontSize: 18),)
                ],
              ) 
          ),
          const SizedBox(height: 25),
          ElevatedButton(onPressed: openDatePicker, child: Text("Open Date Picker"),),
        ],
      ),
    );
  }
}
