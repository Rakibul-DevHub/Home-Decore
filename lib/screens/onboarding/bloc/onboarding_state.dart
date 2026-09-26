import 'package:equatable/equatable.dart';

final class OnboardingState extends Equatable {
  const OnboardingState({
    this.pageIndex = 0,
    this.finished = false,
  });

  final int pageIndex;

  /// True when next was pressed on the last page (navigate to sign-in).
  final bool finished;

  OnboardingState copyWith({
    int? pageIndex,
    bool? finished,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      finished: finished ?? this.finished,
    );
  }

  @override
  List<Object?> get props => [pageIndex, finished];
}
