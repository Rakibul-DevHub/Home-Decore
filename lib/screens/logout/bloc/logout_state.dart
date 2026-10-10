import 'package:equatable/equatable.dart';

final class LogoutState extends Equatable {
  const LogoutState({this.loggingOut = false});

  /// True while the logout is in progress. The screen listens for the
  /// false → true transition and navigates to the login route.
  final bool loggingOut;

  LogoutState copyWith({bool? loggingOut}) {
    return LogoutState(loggingOut: loggingOut ?? this.loggingOut);
  }

  @override
  List<Object?> get props => [loggingOut];
}