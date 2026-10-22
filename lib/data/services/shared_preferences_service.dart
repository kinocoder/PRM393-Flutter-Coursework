import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_service.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesService sharedPreferencesService(Ref ref){
  return SharedPreferencesService();

}

class SharedPreferencesService {
  static const String _KDarkMode = 'darkMode';

  Future<void> setDarkMode(bool value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_KDarkMode, value);
  }

  Future<bool> isDarkMode() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_KDarkMode) ?? false;
  }
}