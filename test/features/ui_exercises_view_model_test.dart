import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoc_tren_truong/features/ui_exercises/viewmodel/counter_view_model.dart';
import 'package:hoc_tren_truong/features/ui_exercises/viewmodel/theme_view_model.dart';
import 'package:hoc_tren_truong/features/ui_exercises/viewmodel/input_controls_view_model.dart';

void main() {
  test('Synchronous ViewModels publish immutable Riverpod state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.listen(counterViewModelProvider, (_, next) {});
    container.listen(themeViewModelProvider, (_, next) {});
    container.listen(inputControlsViewModelProvider, (_, next) {});
    container.read(counterViewModelProvider.notifier).increment();
    expect(container.read(counterViewModelProvider), 1);
    container.read(themeViewModelProvider.notifier).setDarkMode(true);
    expect(container.read(themeViewModelProvider), isTrue);
    final before = container.read(inputControlsViewModelProvider);
    final vm = container.read(inputControlsViewModelProvider.notifier);
    vm.setRating(80);
    vm.confirmRating(80);
    vm.setActive(true);
    vm.setGenre('Action');
    vm.setDate(DateTime(2026, 10, 5));
    expect(container.read(inputControlsViewModelProvider).rating, 80);
    expect(container.read(inputControlsViewModelProvider).isActive, isTrue);
    expect(before.rating, 0);
    vm.setGenre(null);
    expect(container.read(inputControlsViewModelProvider).genre, isNull);
  });
}
