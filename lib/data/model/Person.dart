import 'package:hoc_tren_truong/data/model/Student.dart';
import 'package:hoc_tren_truong/data/model/Teacher.dart';

enum PersonType{
  STUDENT,
  TEACHER
}

class Person{
  final String id;
  final String name;

  Person ({required this.id,required this.name});
  
  factory Person.create(PersonType personType, String id, String name, Map<String,dynamic> value){
    if(personType == PersonType.TEACHER){
      return new Teacher(
          id: value["id"] as String,
          value["name"] as String);
    }else{
      return new Student(id:value["id"] as String,
                            value["name"]as String,
                            value["Math"] as num,
                            value["Physical"] as num,
                            value["Chemical"] as num);

    }
  }
}