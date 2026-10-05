import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/menu_data.dart';
import 'menu_event.dart';
import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuState()) {
    on<MenuItemTapped>(_onItemTapped);
    on<MenuLogoutRequested>(_onLogoutRequested);
  }

  void _onItemTapped(MenuItemTapped event, Emitter<MenuState> emit) {
    emit(state.copyWith(lastTappedId: event.id));
    // Row-level navigation is handled by the screen via a BlocListener —
    // the bloc only tracks which row was chosen.
  }

  void _onLogoutRequested(
      MenuLogoutRequested event,
      Emitter<MenuState> emit,
      ) {
    emit(state.copyWith(loggingOut: true));
    // Hook a real sign-out (Firebase / API / local storage clear) here.
    // The UI listens for `loggingOut == true` and navigates away.
  }
}