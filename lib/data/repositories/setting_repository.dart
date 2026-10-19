import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_repository.g.dart';

enum Language { vn, en }

@riverpod
Settingrepository1 settingrepository1(Ref ref) {
  return Settingrepository1();
}

// Ngôn ngữ
class Settingrepository1 {
  Future<Language> getLang() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final language = sharedPreferences.getString('language') ?? 'VN';
    return language == 'EN' ? Language.en : Language.vn;
  }

  Future<void> setLanguage(Language language) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      'language',
      language == Language.en ? 'EN' : 'VN',
    );
  }
}
