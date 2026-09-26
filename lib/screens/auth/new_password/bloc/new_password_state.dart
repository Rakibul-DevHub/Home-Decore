import 'package:equatable/equatable.dart';

final class NewPasswordState extends Equatable {
  const NewPasswordState({
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
  });

  final bool passwordVisible;
  final bool confirmPasswordVisible;

  NewPasswordState copyWith({
    bool? passwordVisible,
    bool? confirmPasswordVisible,
  }) {
    return NewPasswordState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [passwordVisible, confirmPasswordVisible];
}
