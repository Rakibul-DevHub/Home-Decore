import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/otp_verification_data.dart';

class OtpVerificationCubit extends Cubit<String> {
  OtpVerificationCubit() : super(OtpVerificationData.initialCode);

  void updateDigit(int index, String value) {
    final digits = state.padRight(OtpVerificationData.digits).split('');
    digits[index] = value.isEmpty ? ' ' : value[value.length - 1];
    emit(digits.join().trimRight());
  }

  void resend() => emit(OtpVerificationData.initialCode);
}
