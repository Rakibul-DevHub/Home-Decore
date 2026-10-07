import 'package:flutter_bloc/flutter_bloc.dart';

import 'bids_menu_event.dart';
import 'bids_menu_state.dart';

class BidsMenuBloc extends Bloc<BidsMenuEvent, BidsMenuState> {
  BidsMenuBloc() : super(const BidsMenuState()) {
    on<BidsMenuTabChanged>(_onTabChanged);
    on<BidsMenuListingOpened>(_onOpened);
  }

  void _onTabChanged(BidsMenuTabChanged event, Emitter<BidsMenuState> emit) {
    if (event.tab == state.tab) return;
    emit(state.copyWith(tab: event.tab));
  }

  void _onOpened(
      BidsMenuListingOpened event,
      Emitter<BidsMenuState> emit,
      ) {
    // Navigation is handled by the screen. Kept as a hook for analytics.
  }
}