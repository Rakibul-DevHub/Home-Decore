import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashStatus { idle, running, ready }

final class SplashState extends Equatable {
  const SplashState({this.status = SplashStatus.idle});

  final SplashStatus status;

  bool get isReady => status == SplashStatus.ready;

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}

/// Holds the splash on screen for [duration], then signals navigation.
///
/// Optional [bootstrap] work runs in parallel with the minimum display time
/// so cold start feels intentional without blocking longer than needed.
class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.duration,
    this._bootstrap,
  }) : super(const SplashState());

  final Duration duration;
  final Future<void> Function()? _bootstrap;

  bool _started = false;

  Future<void> start() async {
    if (_started || isClosed) return;
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
