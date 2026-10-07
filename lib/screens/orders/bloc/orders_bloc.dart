import 'package:flutter_bloc/flutter_bloc.dart';

import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(const OrdersState()) {
    on<OrdersTabChanged>(_onTabChanged);
    on<OrdersTrackRequested>(_onTrackRequested);
    on<OrdersItemOpened>(_onItemOpened);
  }

  void _onTabChanged(OrdersTabChanged event, Emitter<OrdersState> emit) {
    if (event.tab == state.tab) return;
    emit(state.copyWith(tab: event.tab));
  }

  void _onTrackRequested(
      OrdersTrackRequested event,
      Emitter<OrdersState> emit,
      ) {
    // TODO: open the tracking screen / deep link for [event.orderId].
  }

  void _onItemOpened(
      OrdersItemOpened event,
      Emitter<OrdersState> emit,
      ) {
    // TODO: navigate to the order detail screen.
  }
}