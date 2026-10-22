import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hoc_tren_truong/data/repositories/theme_repository.dart';

part 'theme_view_model.g.dart';

@Riverpod(keepAlive: true)
class ThemeViewModel extends _$ThemeViewModel {

  @override
  Future<bool> build() async {
    final repository = ref.watch(themeRepositoryProvider);

    return repository.isDarkMode();
  }

  Future<void> changeDarkMode(bool isDark) async {
    final repository = ref.read(themeRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await repository.setDarkMode(isDark);
      return isDark;
    });
  }
}