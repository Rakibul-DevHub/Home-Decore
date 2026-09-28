import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/search_data.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState(recent: SearchData.recent)) {
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchPersonRemoved>(_onPersonRemoved);
    on<SearchRecentCleared>(_onRecentCleared);
  }

  void _onQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) {
    emit(state.copyWith(query: event.query));
  }

  void _onPersonRemoved(SearchPersonRemoved event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        recent: state.recent.where((person) => person.id != event.id).toList(),
      ),
    );
  }

  void _onRecentCleared(SearchRecentCleared event, Emitter<SearchState> emit) {
    emit(state.copyWith(recent: const []));
  }
}
