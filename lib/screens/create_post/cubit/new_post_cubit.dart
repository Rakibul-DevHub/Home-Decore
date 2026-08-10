import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/new_post_data.dart';

class NewPostState extends Equatable {
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

class NewPostCubit extends Cubit<NewPostState> {
  NewPostCubit() : super(const NewPostState());

  void toggleImage(int index) {
    final selected = [...state.selectedIndexes];
    if (selected.contains(index)) {
      if (selected.length == 1) return;
      selected.remove(index);
      final preview = selected.contains(state.previewIndex)
          ? state.previewIndex
          : selected.first;
      emit(state.copyWith(selectedIndexes: selected, previewIndex: preview));
      return;
    }
    selected.add(index);
    emit(state.copyWith(selectedIndexes: selected, previewIndex: index));
  }

  void setPreview(int index) {
    emit(state.copyWith(previewIndex: index));
  }

  void removeSelected(int galleryIndex) {
    final selected = [...state.selectedIndexes]..remove(galleryIndex);
    if (selected.isEmpty) return;
    final preview = selected.contains(state.previewIndex)
        ? state.previewIndex
        : selected.first;
    emit(state.copyWith(selectedIndexes: selected, previewIndex: preview));
  }

  void captionChanged(String value) {
    if (value.length > NewPostData.maxCaptionLength) return;
    emit(state.copyWith(caption: value));
  }
}
