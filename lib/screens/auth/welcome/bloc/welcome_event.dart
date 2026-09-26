import 'package:equatable/equatable.dart';

sealed class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object?> get props => [];
}

final class WelcomePasswordVisibilityToggled extends WelcomeEvent {
  const WelcomePasswordVisibilityToggled();
}
