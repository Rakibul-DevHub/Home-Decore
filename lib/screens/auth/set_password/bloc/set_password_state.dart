import 'package:equatable/equatable.dart';

final class SetPasswordState extends Equatable {
  const SetPasswordState({
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
  });

  final bool passwordVisible;
  final bool confirmPasswordVisible;

  SetPasswordState copyWith({
    bool? passwordVisible,
    bool? confirmPasswordVisible,
  }) {
    return SetPasswordState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [passwordVisible, confirmPasswordVisible];
}
