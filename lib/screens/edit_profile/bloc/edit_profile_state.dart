import 'package:equatable/equatable.dart';

import '../data/edit_profile_data.dart';

final class EditProfileState extends Equatable {
  const EditProfileState({
    required this.original,
    required this.draft,
    this.saving = false,
  });

  /// The values that were loaded when the screen first opened.
  final EditProfileValues original;

  /// The current values being edited.
  final EditProfileValues draft;

  /// True while a save is in flight.
  final bool saving;

  static const initial = EditProfileState(
    original: EditProfileData.initial,
    draft: EditProfileData.initial,
  );

  /// True when the draft differs from the original in any field.
  bool get hasChanges => draft != original;

  /// True when the draft has no empty required fields.
  bool get isValid =>
      draft.name.trim().isNotEmpty &&
          draft.username.trim().isNotEmpty;

  /// Save button enabled only when there are valid changes to save.
  bool get canSave => hasChanges && isValid && !saving;

  /// "kolek.io/@simone.albers" — strips a leading @ from the username
  /// if the user typed one, then prepends a single @.
  String get profileUrl {
    var handle = draft.username.trim();
    while (handle.startsWith('@')) {
      handle = handle.substring(1);
    }
    if (handle.isEmpty) return EditProfileData.profileUrlBase;
    return '${EditProfileData.profileUrlBase}@$handle';
  }

  EditProfileState copyWith({
    EditProfileValues? original,
    EditProfileValues? draft,
    bool? saving,
  }) {
    return EditProfileState(
      original: original ?? this.original,
      draft: draft ?? this.draft,
      saving: saving ?? this.saving,
    );
  }

  @override
  List<Object?> get props => [original, draft, saving];
}