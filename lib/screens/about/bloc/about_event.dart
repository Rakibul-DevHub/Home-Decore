import 'package:equatable/equatable.dart';

sealed class AboutEvent extends Equatable {
  const AboutEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped the support email link.
final class AboutEmailTapped extends AboutEvent {
  const AboutEmailTapped();
}