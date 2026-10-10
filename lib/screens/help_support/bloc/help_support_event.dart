import 'package:equatable/equatable.dart';

sealed class HelpSupportEvent extends Equatable {
  const HelpSupportEvent();

  @override
  List<Object?> get props => [];
}

/// User typed in the search field.
final class HelpSupportSearchChanged extends HelpSupportEvent {
  const HelpSupportSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

/// User tapped a topic row.
final class HelpSupportTopicTapped extends HelpSupportEvent {
  const HelpSupportTopicTapped(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// User tapped an FAQ row.
final class HelpSupportFaqTapped extends HelpSupportEvent {
  const HelpSupportFaqTapped(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// User tapped the "Contact Support" button.
final class HelpSupportContactRequested extends HelpSupportEvent {
  const HelpSupportContactRequested();
}

/// User tapped a report row (Report a Problem / Report a Safety Issue).
final class HelpSupportReportTapped extends HelpSupportEvent {
  const HelpSupportReportTapped(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}