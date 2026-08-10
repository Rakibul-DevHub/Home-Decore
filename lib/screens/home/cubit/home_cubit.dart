import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState extends Equatable {
  const HomeState({this.savedPostIds = const {}, this.activePostId});

  final Set<String> savedPostIds;
  final String? activePostId;

  HomeState copyWith({
    Set<String>? savedPostIds,
    String? activePostId,
    bool clearActivePost = false,
  }) => HomeState(
    savedPostIds: savedPostIds ?? this.savedPostIds,
    activePostId: clearActivePost ? null : activePostId ?? this.activePostId,
  );

  @override
  List<Object?> get props => [savedPostIds, activePostId];
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void toggleSaved(String postId) {
    final saved = {...state.savedPostIds};
    saved.contains(postId) ? saved.remove(postId) : saved.add(postId);
    emit(state.copyWith(savedPostIds: saved));
  }

  void openComments(String postId) {
    emit(state.copyWith(activePostId: postId));
  }

  void closeComments() {
    emit(state.copyWith(clearActivePost: true));
  }
}
