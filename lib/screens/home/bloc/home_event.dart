import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeSavedToggled extends HomeEvent {
  const HomeSavedToggled(this.postId);

  final String postId;

  @override
  List<Object?> get props => [postId];
}

final class HomeCommentsOpened extends HomeEvent {
  const HomeCommentsOpened(this.postId);

  final String postId;

  @override
  List<Object?> get props => [postId];
}

final class HomeCommentsClosed extends HomeEvent {
  const HomeCommentsClosed();
}
