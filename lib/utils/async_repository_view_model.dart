import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Immutable data plus the state of a mutation. Load state uses AsyncValue.
class FeatureState<T> {
  const FeatureState(this.data, {this.isBusy = false, this.actionError});
  final T data;
  final bool isBusy;
  final Object? actionError;
}

/// Bridges repository notifications to Riverpod; Views only observe providers.
abstract class AsyncRepositoryViewModel<T>
    extends AsyncNotifier<FeatureState<T>> {
  int _generation = 0;
  bool _running = false;

  @protected
  Future<FeatureState<T>> observeRepository(
    Listenable repository, {
    required Future<void> Function() load,
    required T Function() snapshot,
  }) async {
    final generation = ++_generation;
    _running = false;
    void sync() {
      if (!ref.mounted || generation != _generation || state.isLoading) return;
      final previous = state.asData?.value;
      if (previous != null) {
        state = AsyncData(
          FeatureState(
            snapshot(),
            isBusy: previous.isBusy,
            actionError: previous.actionError,
          ),
        );
      }
    }

    repository.addListener(sync);
    ref.onDispose(() {
      repository.removeListener(sync);
      if (generation == _generation) _generation++;
    });
    await load();
    return FeatureState(snapshot());
  }

  /// Serializes commands per ViewModel and preserves data on mutation failure.
  /// A disposed/rebuilt provider never receives an old command's completion.
  @protected
  Future<bool> mutate(Future<void> Function() action) async {
    if (_running) return false;
    _running = true;
    final generation = _generation;
    bool active() => ref.mounted && generation == _generation;
    try {
      await future;
      if (!active()) return false;
      state = AsyncData(FeatureState(state.requireValue.data, isBusy: true));
      await action();
      if (!active()) return false;
      state = AsyncData(FeatureState(state.requireValue.data));
      return true;
    } catch (error, stack) {
      if (active()) {
        final current = state.asData?.value;
        state = current == null
            ? AsyncError(error, stack)
            : AsyncData(FeatureState(current.data, actionError: error));
      }
      return false;
    } finally {
      if (active()) _running = false;
    }
  }
}
