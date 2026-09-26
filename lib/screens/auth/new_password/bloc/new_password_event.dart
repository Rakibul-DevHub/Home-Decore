import 'package:equatable/equatable.dart';

sealed class NewPasswordEvent extends Equatable {
  const NewPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class NewPasswordVisibilityToggled extends NewPasswordEvent {
  const NewPasswordVisibilityToggled();
}

final class NewConfirmPasswordVisibilityToggled extends NewPasswordEvent {
  const NewConfirmPasswordVisibilityToggled();
}
