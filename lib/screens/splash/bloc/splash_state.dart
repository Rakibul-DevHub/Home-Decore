import 'package:equatable/equatable.dart';

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
