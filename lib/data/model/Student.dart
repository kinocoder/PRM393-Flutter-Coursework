import 'package:hoc_tren_truong/data/model/Person.dart';

class Student extends Person{
  final double? math;
  final double? physical;
  final double? chemical;

  Student({required super.id, required super.name, this.math=0, this.chemical=0, this.physical=0});

  Student CopyStudent({String? id, String? name, double? math, double? physical, double? chemical}){
    return new Student(
        id:id??this.id,
        name:name??this.name,
        math: math??this.math,
        chemical: chemical??this.chemical,
        physical: physical??this.physical
    );
  }

  factory Student.FromJson(Map<String, dynamic> json){
    return new Student(
        id: json['id'] as String,
        name: json['name'] as String,
        math: (json['math'] as num).toDouble() ,
        chemical: (json['chemical'] as num).toDouble(),
        physical: (json['physical'] as num).toDouble());

  }
}