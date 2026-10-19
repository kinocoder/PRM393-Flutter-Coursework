import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_repository.g.dart';


enum Language {
  VN,
  EN
}

@riverpod
Settingrepository1 settingrepository1(Ref ref){
  Settingrepository1();
}

//Ngôn ngữ
class Settingrepository1 {
  Future<Language> getLang() async {
    //bước 1 Khai báo 1 instant
    var shareReference = await SharedPreferences.getInstance();
    var language = shareReference.getString('language')??'VN';
    return language == 'EN'?Language.EN:Language.VN;
  }

  Future<void> setLanguage(Language language) async{
    var shareReference = await SharedPreferences.getInstance();
    shareReference.setString('language', language==Language.EN?'EN':'VN');
  }
}