import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/profile_data.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ProfileTabSelected>(_onTabSelected);
  }

  void _onTabSelected(
      ProfileTabSelected event,
      Emitter<ProfileState> emit,
      ) {
    if (event.index < 0 || event.index >= ProfileData.tabs.length) return;
    if (event.index == state.tabIndex) return;
    emit(state.copyWith(tabIndex: event.index));
  }
}