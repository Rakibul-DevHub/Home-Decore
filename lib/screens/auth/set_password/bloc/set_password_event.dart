import 'package:equatable/equatable.dart';

sealed class SetPasswordEvent extends Equatable {
  const SetPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class SetPasswordVisibilityToggled extends SetPasswordEvent {
  const SetPasswordVisibilityToggled();
}

final class SetConfirmPasswordVisibilityToggled extends SetPasswordEvent {
  const SetConfirmPasswordVisibilityToggled();
}
