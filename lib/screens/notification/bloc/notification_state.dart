import 'package:equatable/equatable.dart';

import '../data/notification_data.dart';

final class NotificationState extends Equatable {
  const NotificationState({
    required this.today,
    required this.thisWeek,
  });

  final List<AppNotification> today;
  final List<AppNotification> thisWeek;

  NotificationState copyWith({
    List<AppNotification>? today,
    List<AppNotification>? thisWeek,
  }) {
    return NotificationState(
      today: today ?? this.today,
      thisWeek: thisWeek ?? this.thisWeek,
    );
  }

  @override
  List<Object> get props => [today, thisWeek];
}
