import 'package:equatable/equatable.dart';

sealed class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object?> get props => [];
}

final class OtpDigitUpdated extends OtpVerificationEvent {
  const OtpDigitUpdated({required this.index, required this.value});

  final int index;
  final String value;

  @override
  List<Object?> get props => [index, value];
}

final class OtpResendRequested extends OtpVerificationEvent {
  const OtpResendRequested();
}
