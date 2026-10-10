import 'package:equatable/equatable.dart';

import '../data/privacy_data.dart';

sealed class PrivacyEvent extends Equatable {
  const PrivacyEvent();

  @override
  List<Object?> get props => [];
}

/// User flipped a toggle.
final class PrivacyToggleChanged extends PrivacyEvent {
  const PrivacyToggleChanged(this.id, this.value);

  final PrivacyToggleId id;
  final bool value;

  @override
  List<Object?> get props => [id, value];
}

/// User tapped a navigation row.
final class PrivacyNavRowTapped extends PrivacyEvent {
  const PrivacyNavRowTapped(this.id);

  final PrivacyRowId id;

  @override
  List<Object?> get props => [id];
}