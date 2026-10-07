import 'package:equatable/equatable.dart';

/// Which primary action the user picked on the Create screen.
enum CreateAction { none, post, product }

final class CreateState extends Equatable {
  const CreateState({
    this.lastAction = CreateAction.none,
    this.submitting = false,
  });

  /// The most recent action the user requested. The screen listens for
  /// changes here and performs the matching navigation / side effect,
  /// then dispatches [CreateActionHandled] to reset it.
  final CreateAction lastAction;

  /// Reserved for future use — while a product listing or post is being
  /// submitted, this can gate the UI (e.g. disable taps, show a spinner).
  final bool submitting;

  CreateState copyWith({
    CreateAction? lastAction,
    bool? submitting,
  }) {
    return CreateState(
      lastAction: lastAction ?? this.lastAction,
      submitting: submitting ?? this.submitting,
    );
  }

  @override
  List<Object?> get props => [lastAction, submitting];
}