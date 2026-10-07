import 'package:equatable/equatable.dart';

import '../data/settings_data.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.sections = SettingsData.sections,
    this.lastTappedId,
    this.loggingOut = false,
    this.deletingAccount = false,
  });

  final List<SettingsSection> sections;

  /// Most recently tapped row, used for analytics / tracking.
  final String? lastTappedId;

  final bool loggingOut;
  final bool deletingAccount;

  SettingsState copyWith({
    List<SettingsSection>? sections,
    String? lastTappedId,
    bool? loggingOut,
    bool? deletingAccount,
  }) {
    return SettingsState(
      sections: sections ?? this.sections,
      lastTappedId: lastTappedId ?? this.lastTappedId,
      loggingOut: loggingOut ?? this.loggingOut,
      deletingAccount: deletingAccount ?? this.deletingAccount,
    );
  }

  @override
  List<Object?> get props =>
      [sections, lastTappedId, loggingOut, deletingAccount];
}