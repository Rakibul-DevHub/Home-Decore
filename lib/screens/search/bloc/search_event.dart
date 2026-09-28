import 'package:equatable/equatable.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

final class SearchQueryChanged extends SearchEvent {
  const SearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class SearchPersonRemoved extends SearchEvent {
  const SearchPersonRemoved(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class SearchRecentCleared extends SearchEvent {
  const SearchRecentCleared();
}
