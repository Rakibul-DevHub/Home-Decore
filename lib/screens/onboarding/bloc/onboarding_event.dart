import 'package:equatable/equatable.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

final class OnboardingNextPressed extends OnboardingEvent {
  const OnboardingNextPressed();
}

final class OnboardingPreviousPressed extends OnboardingEvent {
  const OnboardingPreviousPressed();
}
