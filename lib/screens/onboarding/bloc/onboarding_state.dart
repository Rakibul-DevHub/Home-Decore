import 'package:equatable/equatable.dart';

final class OnboardingState extends Equatable {
  const OnboardingState({
    this.pageIndex = 0,
    this.finished = false,
    this.isForward = true,
  });

  final int pageIndex;

  /// True when next was pressed on the last page (navigate to sign-in).
  final bool finished;

  /// Page change direction — used for enter/exit slide animation.
  final bool isForward;

  OnboardingState copyWith({
    int? pageIndex,
    bool? finished,
    bool? isForward,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      finished: finished ?? this.finished,
      isForward: isForward ?? this.isForward,
    );
  }

  @override
  List<Object?> get props => [pageIndex, finished, isForward];
}
