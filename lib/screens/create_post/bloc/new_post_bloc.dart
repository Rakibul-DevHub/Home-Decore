// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../data/new_post_data.dart';
// import 'new_post_event.dart';
// import 'new_post_state.dart';
//
// class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
//   NewPostBloc() : super(const NewPostState()) {
//     on<NewPostImageToggled>(_onImageToggled);
//     on<NewPostPreviewSet>(_onPreviewSet);
//     on<NewPostImageRemoved>(_onImageRemoved);
//     on<NewPostCaptionChanged>(_onCaptionChanged);
//   }
//
//   void _onImageToggled(
//       NewPostImageToggled event,
//       Emitter<NewPostState> emit,
//       ) {
//     final selected = [...state.selectedIndexes];
//     if (selected.contains(event.index)) {
//       // Never allow the selection to become empty.
//       if (selected.length == 1) return;
//       selected.remove(event.index);
//       final preview = selected.contains(state.previewIndex)
//           ? state.previewIndex
//           : selected.first;
//       emit(state.copyWith(
//         selectedIndexes: selected,
//         previewIndex: preview,
//       ));
//       return;
//     }
//     selected.add(event.index);
//     emit(state.copyWith(
//       selectedIndexes: selected,
//       previewIndex: event.index,
//     ));
//   }
//
//   void _onPreviewSet(
//       NewPostPreviewSet event,
//       Emitter<NewPostState> emit,
//       ) {
//     emit(state.copyWith(previewIndex: event.index));
//   }
//
//   void _onImageRemoved(
//       NewPostImageRemoved event,
//       Emitter<NewPostState> emit,
//       ) {
//     final selected = [...state.selectedIndexes]..remove(event.galleryIndex);
//     if (selected.isEmpty) return;
//     final preview = selected.contains(state.previewIndex)
//         ? state.previewIndex
//         : selected.first;
//     emit(state.copyWith(
//       selectedIndexes: selected,
//       previewIndex: preview,
//     ));
//   }
//
//   void _onCaptionChanged(
//       NewPostCaptionChanged event,
//       Emitter<NewPostState> emit,
//       ) {
//     if (event.value.length > NewPostData.maxCaptionLength) return;
//     emit(state.copyWith(caption: event.value));
//   }
// }















import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/new_post_data.dart';
import 'new_post_event.dart';
import 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  NewPostBloc() : super(const NewPostState()) {
    on<NewPostImageToggled>(_onImageToggled);
    on<NewPostPreviewSet>(_onPreviewSet);
    on<NewPostImageRemoved>(_onImageRemoved);
    on<NewPostCaptionChanged>(_onCaptionChanged);
    on<NewPostHashtagsToggled>(_onHashtagsToggled);
    on<NewPostHashtagAdded>(_onHashtagAdded);
    on<NewPostHashtagRemoved>(_onHashtagRemoved);
  }

  void _onImageToggled(
      NewPostImageToggled event,
      Emitter<NewPostState> emit,
      ) {
    final selected = [...state.selectedIndexes];
    if (selected.contains(event.index)) {
      if (selected.length == 1) return;
      selected.remove(event.index);
      final preview = selected.contains(state.previewIndex)
          ? state.previewIndex
          : selected.first;
      emit(state.copyWith(
        selectedIndexes: selected,
        previewIndex: preview,
      ));
      return;
    }
    selected.add(event.index);
    emit(state.copyWith(
      selectedIndexes: selected,
      previewIndex: event.index,
    ));
  }

  void _onPreviewSet(NewPostPreviewSet event, Emitter<NewPostState> emit) {
    emit(state.copyWith(previewIndex: event.index));
  }

  void _onImageRemoved(
      NewPostImageRemoved event,
      Emitter<NewPostState> emit,
      ) {
    final selected = [...state.selectedIndexes]..remove(event.galleryIndex);
    if (selected.isEmpty) return;
    final preview = selected.contains(state.previewIndex)
        ? state.previewIndex
        : selected.first;
    emit(state.copyWith(
      selectedIndexes: selected,
      previewIndex: preview,
    ));
  }

  void _onCaptionChanged(
      NewPostCaptionChanged event,
      Emitter<NewPostState> emit,
      ) {
    if (event.value.length > NewPostData.maxCaptionLength) return;
    emit(state.copyWith(caption: event.value));
  }

  void _onHashtagsToggled(
      NewPostHashtagsToggled event,
      Emitter<NewPostState> emit,
      ) {
    emit(state.copyWith(hashtagsExpanded: !state.hashtagsExpanded));
  }

  void _onHashtagAdded(
      NewPostHashtagAdded event,
      Emitter<NewPostState> emit,
      ) {
    // Normalize: trim, strip leading '#', lowercase for comparison.
    var tag = event.tag.trim();
    if (tag.startsWith('#')) tag = tag.substring(1);
    tag = tag.trim();
    if (tag.isEmpty) return;

    // Deduplicate case-insensitively but preserve the user's casing
    // for the first occurrence.
    final exists = state.hashtags
        .any((existing) => existing.toLowerCase() == tag.toLowerCase());
    if (exists) return;

    emit(state.copyWith(hashtags: [...state.hashtags, tag]));
  }

  void _onHashtagRemoved(
      NewPostHashtagRemoved event,
      Emitter<NewPostState> emit,
      ) {
    emit(state.copyWith(
      hashtags: state.hashtags
          .where((tag) => tag != event.tag)
          .toList(growable: false),
    ));
  }
}