import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/onboarding_data.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  bool nextPage() {
    if (state >= OnboardingData.pages.length - 1) {
      return true;
    }
    emit(state + 1);
    return false;
  }

  void previousPage() {
    if (state > 0) {
      emit(state - 1);
    }
  }
}
