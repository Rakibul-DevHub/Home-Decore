import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_event.dart';
import 'splash_state.dart';

/// Holds the splash on screen for [duration], then signals navigation.
///
/// Optional [bootstrap] work runs in parallel with the minimum display time
/// so cold start feels intentional without blocking longer than needed.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required this.duration,
    Future<void> Function()? bootstrap,
  })  : _bootstrap = bootstrap,
        super(const SplashState()) {
    on<SplashStarted>(_onStarted);
  }

  final Duration duration;
  final Future<void> Function()? _bootstrap;

  bool _started = false;

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    if (_started) return;
    _started = true;
    emit(state.copyWith(status: SplashStatus.running));

    final bootstrap = _bootstrap;
    try {
      await Future.wait<void>([
        Future<void>.delayed(duration),
        if (bootstrap != null) bootstrap(),
      ]);
    } catch (_) {
      // Still leave splash so the user is never stuck on a failed bootstrap.
    }

    if (!isClosed) {
      emit(state.copyWith(status: SplashStatus.ready));
    }
  }
}
