import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeSavedToggled>(_onSavedToggled);
    on<HomeCommentsOpened>(_onCommentsOpened);
    on<HomeCommentsClosed>(_onCommentsClosed);
  }

  void _onSavedToggled(HomeSavedToggled event, Emitter<HomeState> emit) {
    final saved = {...state.savedPostIds};
    saved.contains(event.postId) ? saved.remove(event.postId) : saved.add(event.postId);
    emit(state.copyWith(savedPostIds: saved));
  }

  void _onCommentsOpened(HomeCommentsOpened event, Emitter<HomeState> emit) {
    emit(state.copyWith(activePostId: event.postId));
  }

  void _onCommentsClosed(HomeCommentsClosed event, Emitter<HomeState> emit) {
    emit(state.copyWith(clearActivePost: true));
  }
}
