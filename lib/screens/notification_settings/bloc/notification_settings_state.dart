import 'package:equatable/equatable.dart';

import '../data/notification_settings_data.dart';

final class NotificationSettingsState extends Equatable {
  const NotificationSettingsState({
    required this.values,
    required this.sections,
    this.saving = false,
  });

  /// Current on/off value for every toggle.
  final Map<NotificationToggleId, bool> values;

  /// Section/row layout. Held in state so a future "loading" state can
  /// replace it with server-defined sections.
  final List<NotificationSection> sections;

  final bool saving;

  static const initial = NotificationSettingsState(
    values: NotificationSettingsData.initialValues,
    sections: NotificationSettingsData.sections,
  );

  bool valueOf(NotificationToggleId id) => values[id] ?? false;

  NotificationSettingsState copyWith({
    Map<NotificationToggleId, bool>? values,
    List<NotificationSection>? sections,
    bool? saving,
  }) {
    return NotificationSettingsState(
      values: values ?? this.values,
      sections: sections ?? this.sections,
      saving: saving ?? this.saving,
    );
  }

  @override
  List<Object?> get props => [values, sections, saving];
}