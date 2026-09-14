

import 'package:hoc_tren_truong/data/model/Person.dart';

class Teacher extends Person{
  List<String>? subjects;

  Teacher({ required super.id, required super.name, this.subjects=const[""]});
}