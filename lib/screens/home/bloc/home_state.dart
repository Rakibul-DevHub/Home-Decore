import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
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
