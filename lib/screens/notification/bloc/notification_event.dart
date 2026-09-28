import 'package:equatable/equatable.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationFollowToggled extends NotificationEvent {
  const NotificationFollowToggled(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
