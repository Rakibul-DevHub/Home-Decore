import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_account_event.dart';
import 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  CreateAccountBloc() : super(const CreateAccountState()) {
    on<CreateAccountProfilePhotoSelected>(_onProfilePhotoSelected);
  }

  void _onProfilePhotoSelected(
    CreateAccountProfilePhotoSelected event,
    Emitter<CreateAccountState> emit,
  ) {
    emit(state.copyWith(hasProfilePhoto: true));
  }
}
