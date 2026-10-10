import 'package:equatable/equatable.dart';

import '../data/password_security_data.dart';

sealed class PasswordSecurityEvent extends Equatable {
  const PasswordSecurityEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped an action on the screen.
final class PasswordSecurityActionPressed extends PasswordSecurityEvent {
  const PasswordSecurityActionPressed(this.action);

  final SecurityAction action;

  @override
  List<Object?> get props => [action];
}