import 'package:equatable/equatable.dart';

import '../data/otp_verification_data.dart';

final class OtpVerificationState extends Equatable {
  const OtpVerificationState({this.code = OtpVerificationData.initialCode});

  final String code;

  OtpVerificationState copyWith({String? code}) {
    return OtpVerificationState(code: code ?? this.code);
  }

  @override
  List<Object?> get props => [code];
}
