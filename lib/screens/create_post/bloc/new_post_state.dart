import 'package:equatable/equatable.dart';

import '../data/new_post_data.dart';

final class NewPostState extends Equatable {
  const NewPostState({
    this.selectedIndexes = const [0],
    this.previewIndex = 0,
    this.caption = '',
  });

  final List<int> selectedIndexes;
  final int previewIndex;
  final String caption;

  List<String> get selectedImages => selectedIndexes
      .map((index) => NewPostData.gallery[index])
      .toList(growable: false);

  NewPostState copyWith({
    List<int>? selectedIndexes,
    int? previewIndex,
    String? caption,
  }) {
    return NewPostState(
      selectedIndexes: selectedIndexes ?? this.selectedIndexes,
      previewIndex: previewIndex ?? this.previewIndex,
      caption: caption ?? this.caption,
    );
  }

  @override
  List<Object> get props => [selectedIndexes, previewIndex, caption];
}