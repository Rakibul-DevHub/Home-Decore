import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.savedPostIds = const {},
    this.likedPostIds = const {},
    this.activePostId,
  });

  final Set<String> savedPostIds;
  final Set<String> likedPostIds;
  final String? activePostId;

  HomeState copyWith({
    Set<String>? savedPostIds,
    Set<String>? likedPostIds,
    String? activePostId,
    bool clearActivePost = false,
  }) => HomeState(
    savedPostIds: savedPostIds ?? this.savedPostIds,
    likedPostIds: likedPostIds ?? this.likedPostIds,
    activePostId: clearActivePost ? null : activePostId ?? this.activePostId,
  );

  @override
  List<Object?> get props => [savedPostIds, likedPostIds, activePostId];
}
