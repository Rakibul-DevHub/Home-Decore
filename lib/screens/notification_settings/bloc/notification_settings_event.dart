import 'package:equatable/equatable.dart';

import '../data/notification_settings_data.dart';

sealed class NotificationSettingsEvent extends Equatable {
  const NotificationSettingsEvent();

  @override
  List<Object?> get props => [];
}

/// User flipped a toggle.
final class NotificationToggleChanged extends NotificationSettingsEvent {
  const NotificationToggleChanged(this.id, this.value);

  final NotificationToggleId id;
  final bool value;

  @override
  List<Object?> get props => [id, value];
}