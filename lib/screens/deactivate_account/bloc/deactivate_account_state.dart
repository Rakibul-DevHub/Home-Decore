import 'package:equatable/equatable.dart';

final class DeactivateAccountState extends Equatable {
  const DeactivateAccountState({
    this.password = '',
    this.passwordVisible = false,
    this.submitting = false,
    this.passwordError,
    this.deactivateSucceeded = false,
    this.deleteSucceeded = false,
  });

  final String password;
  final bool passwordVisible;
  final bool submitting;
  final String? passwordError;
  final bool deactivateSucceeded;
  final bool deleteSucceeded;

  DeactivateAccountState copyWith({
    String? password,
    bool? passwordVisible,
    bool? submitting,
    String? passwordError,
    bool clearPasswordError = false,
    bool? deactivateSucceeded,
    bool? deleteSucceeded,
  }) {
    return DeactivateAccountState(
      password: password ?? this.password,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      submitting: submitting ?? this.submitting,
      passwordError: clearPasswordError
          ? null
          : passwordError ?? this.passwordError,
      deactivateSucceeded: deactivateSucceeded ?? this.deactivateSucceeded,
      deleteSucceeded: deleteSucceeded ?? this.deleteSucceeded,
    );
  }

  @override
  List<Object?> get props => [
    password,
    passwordVisible,
    submitting,
    passwordError,
    deactivateSucceeded,
    deleteSucceeded,
  ];
}
