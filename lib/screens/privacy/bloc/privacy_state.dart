import 'package:equatable/equatable.dart';

import '../data/privacy_data.dart';

final class PrivacyState extends Equatable {
  const PrivacyState({
    required this.values,
    required this.sections,
  });

  final Map<PrivacyToggleId, bool> values;
  final List<PrivacySection> sections;

  static const initial = PrivacyState(
    values: PrivacyData.initialToggleValues,
    sections: PrivacyData.sections,
  );

  bool valueOf(PrivacyToggleId id) => values[id] ?? false;

  PrivacyState copyWith({
    Map<PrivacyToggleId, bool>? values,
    List<PrivacySection>? sections,
  }) {
    return PrivacyState(
      values: values ?? this.values,
      sections: sections ?? this.sections,
    );
  }

  @override
  List<Object?> get props => [values, sections];
}