import 'package:equatable/equatable.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

/// Starts the splash timer / bootstrap work.
final class SplashStarted extends SplashEvent {
  const SplashStarted();
}
