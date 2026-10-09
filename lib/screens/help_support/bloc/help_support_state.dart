import 'package:equatable/equatable.dart';

import '../data/help_support_data.dart';

final class HelpSupportState extends Equatable {
  const HelpSupportState({
    this.query = '',
    this.topics = HelpSupportData.topics,
    this.faqs = HelpSupportData.faqs,
    this.reports = HelpSupportData.reports,
  });

  final String query;
  final List<HelpTopic> topics;
  final List<HelpFaq> faqs;
  final List<HelpReport> reports;

  bool get isSearching => query.trim().isNotEmpty;

  /// Topics whose title or subtitle contains the current query.
  /// Returns the full list when the query is empty.
  List<HelpTopic> get visibleTopics {
    if (!isSearching) return topics;
    final q = query.trim().toLowerCase();
    return topics
        .where(
          (t) =>
      t.title.toLowerCase().contains(q) ||
          t.subtitle.toLowerCase().contains(q),
    )
        .toList(growable: false);
  }

  /// FAQs whose question contains the current query.
  List<HelpFaq> get visibleFaqs {
    if (!isSearching) return faqs;
    final q = query.trim().toLowerCase();
    return faqs
        .where((f) => f.question.toLowerCase().contains(q))
        .toList(growable: false);
  }

  /// Report rows whose title or subtitle contains the current query.
  List<HelpReport> get visibleReports {
    if (!isSearching) return reports;
    final q = query.trim().toLowerCase();
    return reports
        .where(
          (r) =>
      r.title.toLowerCase().contains(q) ||
          r.subtitle.toLowerCase().contains(q),
    )
        .toList(growable: false);
  }

  /// True when a search is active but nothing matches.
  bool get hasNoMatches =>
      isSearching &&
          visibleTopics.isEmpty &&
          visibleFaqs.isEmpty &&
          visibleReports.isEmpty;

  HelpSupportState copyWith({
    String? query,
    List<HelpTopic>? topics,
    List<HelpFaq>? faqs,
    List<HelpReport>? reports,
  }) {
    return HelpSupportState(
      query: query ?? this.query,
      topics: topics ?? this.topics,
      faqs: faqs ?? this.faqs,
      reports: reports ?? this.reports,
    );
  }

  @override
  List<Object?> get props => [query, topics, faqs, reports];
}