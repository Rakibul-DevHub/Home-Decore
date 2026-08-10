import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/search_data.dart';

class SearchState extends Equatable {
  const SearchState({required this.recentSearches, this.query = ''});

  final List<String> recentSearches;
  final String query;

  SearchState copyWith({List<String>? recentSearches, String? query}) =>
      SearchState(
        recentSearches: recentSearches ?? this.recentSearches,
        query: query ?? this.query,
      );

  @override
  List<Object> get props => [recentSearches, query];
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
    : super(const SearchState(recentSearches: SearchData.initialRecent));

  void queryChanged(String value) => emit(state.copyWith(query: value));

  void submit(String value) {
    final query = value.trim();
    if (query.isEmpty) return;
    emit(
      state.copyWith(
        query: query,
        recentSearches: [
          query,
          ...state.recentSearches.where(
            (item) => item.toLowerCase() != query.toLowerCase(),
          ),
        ],
      ),
    );
  }

  void removeRecent(String value) => emit(
    state.copyWith(
      recentSearches: state.recentSearches
          .where((item) => item != value)
          .toList(growable: false),
    ),
  );

  void clearRecent() => emit(state.copyWith(recentSearches: const []));
}
