import 'package:equatable/equatable.dart';

sealed class DeactivateAccountEvent extends Equatable {
  const DeactivateAccountEvent();

  @override
  List<Object?> get props => [];
}

final class DeactivateAccountPasswordChanged extends DeactivateAccountEvent {
  const DeactivateAccountPasswordChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class DeactivateAccountPasswordVisibilityToggled
    extends DeactivateAccountEvent {
  const DeactivateAccountPasswordVisibilityToggled();
}

final class DeactivateAccountSubmitted extends DeactivateAccountEvent {
  const DeactivateAccountSubmitted();
}

final class DeactivateAccountDeleteConfirmed extends DeactivateAccountEvent {
  const DeactivateAccountDeleteConfirmed();
}
