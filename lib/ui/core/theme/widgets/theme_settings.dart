import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/theme_view_model.dart';

class ThemeSettings extends ConsumerWidget {
  const ThemeSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeViewModelProvider);

    return Switch(
      value: themeAsync.value ?? false,
      onChanged: themeAsync.isLoading
          ? null
          : (value) {
        ref
            .read(themeViewModelProvider.notifier)
            .changeDarkMode(value);
      },
    );
  }
}