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

  factory Person.create(PersonType personType, String id, String name, Map<String, dynamic> value) {
    if (personType == PersonType.TEACHER) {
      return Teacher(
        id: id,     // Sử dụng trực tiếp biến id truyền vào hàm
        name: name, // Sửa: Thêm 'name:' vì đây là named parameter
      );
    } else {
      return Student(
        id: id,
        name: name, // Sửa: Thêm 'name:'
        // Sửa: Thêm tên tham số và ép kiểu double an toàn
        math: (value["Math"] as num?)?.toDouble(),
        physical: (value["Physical"] as num?)?.toDouble(),
        chemical: (value["Chemical"] as num?)?.toDouble(),
      );
    }
  }
}