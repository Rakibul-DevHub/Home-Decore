import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(
          const NotificationState(
            today: NotificationData.today,
            thisWeek: NotificationData.thisWeek,
          ),
        );

  void toggleFollow(String id) {
    List<AppNotification> mapList(List<AppNotification> items) {
      return items
          .map((item) {
            if (item.id != id) return item;
            final next = !item.isFollowing;
            return item.copyWith(
              isFollowing: next,
            );
          })
          .toList(growable: false);
    }

    emit(
      state.copyWith(
        today: mapList(state.today),
        thisWeek: mapList(state.thisWeek),
      ),
    );
  }
}
