import 'package:equatable/equatable.dart';

import '../data/account_information_data.dart';

final class AccountInformationState extends Equatable {
  const AccountInformationState({
    required this.original,
    required this.draft,
    this.saving = false,
  });

  /// Values loaded when the screen first opened.
  final AccountInformationValues original;

  /// Current values being edited.
  final AccountInformationValues draft;

  /// True while a save is in flight.
  final bool saving;

  static const initial = AccountInformationState(
    original: AccountInformationData.initial,
    draft: AccountInformationData.initial,
  );

  bool get hasChanges => draft != original;

  /// Name and email must be non-empty. Phone is optional.
  bool get isValid {
    final emailOk = draft.email.contains('@') && draft.email.contains('.');
    return draft.fullName.trim().isNotEmpty && emailOk;
  }

  bool get canSave => hasChanges && isValid && !saving;

  AccountInformationState copyWith({
    AccountInformationValues? original,
    AccountInformationValues? draft,
    bool? saving,
  }) {
    return AccountInformationState(
      original: original ?? this.original,
      draft: draft ?? this.draft,
      saving: saving ?? this.saving,
    );
  }

  @override
  List<Object?> get props => [original, draft, saving];
}