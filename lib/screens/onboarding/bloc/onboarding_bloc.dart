import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/onboarding_data.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<OnboardingNextPressed>(_onNextPressed);
    on<OnboardingPreviousPressed>(_onPreviousPressed);
  }

  void _onNextPressed(
    OnboardingNextPressed event,
    Emitter<OnboardingState> emit,
  ) {
    final lastIndex = OnboardingData.pages.length - 1;
    if (state.pageIndex >= lastIndex) {
      emit(state.copyWith(finished: true));
      return;
    }
    emit(
      state.copyWith(
        pageIndex: state.pageIndex + 1,
        finished: false,
      ),
    );
  }

  void _onPreviousPressed(
    OnboardingPreviousPressed event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.pageIndex <= 0) return;
    emit(
      state.copyWith(
        pageIndex: state.pageIndex - 1,
        finished: false,
      ),
    );
  }
}
