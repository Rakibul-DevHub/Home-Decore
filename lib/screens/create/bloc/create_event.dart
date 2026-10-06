import 'package:equatable/equatable.dart';

sealed class CreateEvent extends Equatable {
  const CreateEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped the "Create Post" card.
final class CreatePostRequested extends CreateEvent {
  const CreatePostRequested();
}

/// User tapped the "List a Product" card.
final class CreateProductRequested extends CreateEvent {
  const CreateProductRequested();
}

/// Navigation/side-effect triggered by the previous action has been consumed.
/// Clears [CreateState.lastAction] so the screen doesn't react twice.
final class CreateActionHandled extends CreateEvent {
  const CreateActionHandled();
}