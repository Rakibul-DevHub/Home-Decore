import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/selling_data.dart';
import 'selling_event.dart';
import 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  SellingBloc() : super(const SellingState()) {
    on<SellingTabChanged>(_onTabChanged);
    on<SellingListingOpened>(_onOpened);
    on<SellingMenuActionSelected>(_onMenuAction);
  }

  void _onTabChanged(SellingTabChanged event, Emitter<SellingState> emit) {
    if (event.tab == state.tab) return;
    emit(state.copyWith(tab: event.tab));
  }

  void _onOpened(SellingListingOpened event, Emitter<SellingState> emit) {
    // Navigation is handled by the screen. This handler exists so the
    // event can be logged / forwarded to analytics later.
  }

  void _onMenuAction(
      SellingMenuActionSelected event,
      Emitter<SellingState> emit,
      ) {
    switch (event.action) {
      case SellingMenuAction.delete:
        emit(
          state.copyWith(
            listings: state.listings
                .where((l) => l.id != event.id)
                .toList(growable: false),
          ),
        );
      case SellingMenuAction.edit:
      case SellingMenuAction.share:
      // TODO: wire edit / share flows.
        break;
    }
  }
}