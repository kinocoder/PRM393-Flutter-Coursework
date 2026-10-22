import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/shared_preferences_service.dart';

part 'theme_repository.g.dart';

@Riverpod(keepAlive: true)
ThemeRepository themeRepository(Ref ref) {
  final service = SharedPreferencesService();

  return ThemeRepository(service);
}

class ThemeRepository {
  final SharedPreferencesService _service;

  ThemeRepository(this._service);

  Future<bool> isDarkMode() {
    return _service.isDarkMode();
  }

  Future<void> setDarkMode(bool value) {
    return _service.setDarkMode(value);
  }
}
