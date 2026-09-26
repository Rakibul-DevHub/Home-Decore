import 'package:equatable/equatable.dart';

final class WelcomeState extends Equatable {
  const WelcomeState({this.passwordVisible = false});

  final bool passwordVisible;

  WelcomeState copyWith({bool? passwordVisible}) {
    return WelcomeState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }

  @override
  List<Object?> get props => [passwordVisible];
}
