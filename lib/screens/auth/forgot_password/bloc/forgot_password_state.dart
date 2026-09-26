import 'package:equatable/equatable.dart';

final class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({this.submitted = false});

  final bool submitted;

  ForgotPasswordState copyWith({bool? submitted}) {
    return ForgotPasswordState(submitted: submitted ?? this.submitted);
  }

  @override
  List<Object?> get props => [submitted];
}
