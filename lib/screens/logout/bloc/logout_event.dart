import 'package:equatable/equatable.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

/// User confirmed the logout.
final class LogoutConfirmed extends LogoutEvent {
  const LogoutConfirmed();
}