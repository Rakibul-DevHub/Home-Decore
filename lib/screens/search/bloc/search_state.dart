import 'package:equatable/equatable.dart';

import '../data/search_data.dart';

final class SearchState extends Equatable {
  const SearchState({required this.recent, this.query = ''});

  final List<SearchPerson> recent;
  final String query;

  List<SearchPerson> get visible {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return recent;
    return recent
        .where(
          (person) =>
              person.name.toLowerCase().contains(q) ||
              (person.handle?.toLowerCase().contains(q) ?? false),
        )
        .toList(growable: false);
  }

  SearchState copyWith({List<SearchPerson>? recent, String? query}) =>
      SearchState(
        recent: recent ?? this.recent,
        query: query ?? this.query,
      );

  @override
  List<Object> get props => [recent, query];
}
