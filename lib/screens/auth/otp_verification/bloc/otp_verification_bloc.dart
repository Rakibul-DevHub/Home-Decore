import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/otp_verification_data.dart';
import 'otp_verification_event.dart';
import 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(const OtpVerificationState()) {
    on<OtpDigitUpdated>(_onDigitUpdated);
    on<OtpResendRequested>(_onResendRequested);
  }

  void _onDigitUpdated(
    OtpDigitUpdated event,
    Emitter<OtpVerificationState> emit,
  ) {
    final digits =
        state.code.padRight(OtpVerificationData.digits).split('');
    digits[event.index] =
        event.value.isEmpty ? ' ' : event.value[event.value.length - 1];
    emit(state.copyWith(code: digits.join().trimRight()));
  }

  void _onResendRequested(
    OtpResendRequested event,
    Emitter<OtpVerificationState> emit,
  ) {
    emit(const OtpVerificationState(code: OtpVerificationData.initialCode));
  }
}
