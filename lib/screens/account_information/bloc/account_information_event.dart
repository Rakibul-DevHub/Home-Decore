import 'package:equatable/equatable.dart';

sealed class AccountInformationEvent extends Equatable {
  const AccountInformationEvent();

  @override
  List<Object?> get props => [];
}

final class AccountFullNameChanged extends AccountInformationEvent {
  const AccountFullNameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class AccountEmailChanged extends AccountInformationEvent {
  const AccountEmailChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class AccountPhoneChanged extends AccountInformationEvent {
  const AccountPhoneChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class AccountPasswordChanged extends AccountInformationEvent {
  const AccountPasswordChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User tapped the "Change" link next to the password field.
final class AccountPasswordChangeRequested extends AccountInformationEvent {
  const AccountPasswordChangeRequested();
}

/// User tapped "Save Changes".
final class AccountSaveRequested extends AccountInformationEvent {
  const AccountSaveRequested();
}

/// Internal: the save completed successfully.
final class AccountSaveCompleted extends AccountInformationEvent {
  const AccountSaveCompleted();
}