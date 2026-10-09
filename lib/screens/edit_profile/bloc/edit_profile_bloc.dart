import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState.initial) {
    on<EditProfileNameChanged>(_onNameChanged);
    on<EditProfileUsernameChanged>(_onUsernameChanged);
    on<EditProfileBioChanged>(_onBioChanged);
    on<EditProfileLocationChanged>(_onLocationChanged);
    on<EditProfilePhotoChangeRequested>(_onPhotoChange);
    on<EditProfileSaveRequested>(_onSave);
    on<EditProfileSaveCompleted>(_onSaveCompleted);
  }

  void _onNameChanged(
      EditProfileNameChanged event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(name: event.value)));
  }

  void _onUsernameChanged(
      EditProfileUsernameChanged event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(username: event.value)));
  }

  void _onBioChanged(
      EditProfileBioChanged event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(bio: event.value)));
  }

  void _onLocationChanged(
      EditProfileLocationChanged event,
      Emitter<EditProfileState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(location: event.value)));
  }

  void _onPhotoChange(
      EditProfilePhotoChangeRequested event,
      Emitter<EditProfileState> emit,
      ) {
    // TODO: open the image picker and upload the new avatar.
  }

  Future<void> _onSave(
      EditProfileSaveRequested event,
      Emitter<EditProfileState> emit,
      ) async {
    if (!state.canSave) return;

    emit(state.copyWith(saving: true));

    // Simulate the network round-trip. Replace with a real API call.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;

    // Promote the draft to the new baseline — this also clears
    // `hasChanges`, which disables the Save button again.
    add(const EditProfileSaveCompleted());
  }

  void _onSaveCompleted(
      EditProfileSaveCompleted event,
      Emitter<EditProfileState> emit,
      ) {
    emit(
      state.copyWith(
        original: state.draft,
        saving: false,
      ),
    );
  }
}