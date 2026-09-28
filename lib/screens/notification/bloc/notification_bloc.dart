import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/notification_data.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc()
      : super(
          const NotificationState(
            today: NotificationData.today,
            thisWeek: NotificationData.thisWeek,
          ),
        ) {
    on<NotificationFollowToggled>(_onFollowToggled);
  }

  void _onFollowToggled(
    NotificationFollowToggled event,
    Emitter<NotificationState> emit,
  ) {
    List<AppNotification> mapList(List<AppNotification> items) {
      return items
          .map((item) {
            if (item.id != event.id) return item;
            return item.copyWith(isFollowing: !item.isFollowing);
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
