import 'package:flutter_bloc/flutter_bloc.dart';

import 'help_support_event.dart';
import 'help_support_state.dart';

class HelpSupportBloc extends Bloc<HelpSupportEvent, HelpSupportState> {
  HelpSupportBloc() : super(const HelpSupportState()) {
    on<HelpSupportSearchChanged>(_onSearchChanged);
    on<HelpSupportTopicTapped>(_onTopicTapped);
    on<HelpSupportFaqTapped>(_onFaqTapped);
    on<HelpSupportContactRequested>(_onContactRequested);
    on<HelpSupportReportTapped>(_onReportTapped);
  }

  void _onSearchChanged(
      HelpSupportSearchChanged event,
      Emitter<HelpSupportState> emit,
      ) {
    emit(state.copyWith(query: event.query));
  }

  void _onTopicTapped(
      HelpSupportTopicTapped event,
      Emitter<HelpSupportState> emit,
      ) {
    // TODO: navigate to the topic detail screen.
  }

  void _onFaqTapped(
      HelpSupportFaqTapped event,
      Emitter<HelpSupportState> emit,
      ) {
    // TODO: open the FAQ answer (bottom sheet or detail screen).
  }

  void _onContactRequested(
      HelpSupportContactRequested event,
      Emitter<HelpSupportState> emit,
      ) {
    // TODO: open the contact-support screen or mail client.
  }

  void _onReportTapped(
      HelpSupportReportTapped event,
      Emitter<HelpSupportState> emit,
      ) {
    // TODO: open the report flow.
  }
}