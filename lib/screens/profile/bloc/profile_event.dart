import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped a profile tab (Works / For Sale / Saved / About).
final class ProfileTabSelected extends ProfileEvent {
  const ProfileTabSelected(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}