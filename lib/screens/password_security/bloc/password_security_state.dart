import 'package:equatable/equatable.dart';

final class PasswordSecurityState extends Equatable {
  const PasswordSecurityState({this.processing = false});

  /// True while a long-running action (e.g. logging out other devices)
  /// is in flight. Currently unused — reserved for future wiring.
  final bool processing;

  PasswordSecurityState copyWith({bool? processing}) {
    return PasswordSecurityState(processing: processing ?? this.processing);
  }

  @override
  List<Object?> get props => [processing];
}