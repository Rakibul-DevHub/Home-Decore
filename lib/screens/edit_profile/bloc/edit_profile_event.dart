import 'package:equatable/equatable.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

/// User edited the full-name field.
final class EditProfileNameChanged extends EditProfileEvent {
  const EditProfileNameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User edited the username field.
final class EditProfileUsernameChanged extends EditProfileEvent {
  const EditProfileUsernameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User edited the bio field.
final class EditProfileBioChanged extends EditProfileEvent {
  const EditProfileBioChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User edited the location field.
final class EditProfileLocationChanged extends EditProfileEvent {
  const EditProfileLocationChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User tapped "Change Profile Photo".
final class EditProfilePhotoChangeRequested extends EditProfileEvent {
  const EditProfilePhotoChangeRequested();
}

/// User tapped "Save".
final class EditProfileSaveRequested extends EditProfileEvent {
  const EditProfileSaveRequested();
}

/// Internal: the save finished successfully.
final class EditProfileSaveCompleted extends EditProfileEvent {
  const EditProfileSaveCompleted();
}