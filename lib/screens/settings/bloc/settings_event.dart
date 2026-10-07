import 'package:equatable/equatable.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped a settings row.
final class SettingsItemTapped extends SettingsEvent {
  const SettingsItemTapped(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// User tapped Log Out.
final class SettingsLogoutRequested extends SettingsEvent {
  const SettingsLogoutRequested();
}

/// User tapped Deactivate or Delete Account.
final class SettingsDeleteAccountRequested extends SettingsEvent {
  const SettingsDeleteAccountRequested();
}