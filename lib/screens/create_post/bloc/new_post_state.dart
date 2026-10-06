// import 'package:equatable/equatable.dart';
//
// import '../data/new_post_data.dart';
//
// final class NewPostState extends Equatable {
//   const NewPostState({
//     this.selectedIndexes = const [0],
//     this.previewIndex = 0,
//     this.caption = '',
//   });
//
//   final List<int> selectedIndexes;
//   final int previewIndex;
//   final String caption;
//
//   List<String> get selectedImages => selectedIndexes
//       .map((index) => NewPostData.gallery[index])
//       .toList(growable: false);
//
//   NewPostState copyWith({
//     List<int>? selectedIndexes,
//     int? previewIndex,
//     String? caption,
//   }) {
//     return NewPostState(
//       selectedIndexes: selectedIndexes ?? this.selectedIndexes,
//       previewIndex: previewIndex ?? this.previewIndex,
//       caption: caption ?? this.caption,
//     );
//   }
//
//   @override
//   List<Object> get props => [selectedIndexes, previewIndex, caption];
// }












import 'package:equatable/equatable.dart';

import '../data/new_post_data.dart';

final class NewPostState extends Equatable {
  const NewPostState({
    this.selectedIndexes = const [0],
    this.previewIndex = 0,
    this.caption = '',
    this.hashtags = const <String>[],
    this.hashtagsExpanded = false,
  });

  final List<int> selectedIndexes;
  final int previewIndex;
  final String caption;

  /// Tags without the leading '#'. Unique.
  final List<String> hashtags;

  /// Whether the "Add Hashtags" row is currently expanded.
  final bool hashtagsExpanded;

  List<String> get selectedImages => selectedIndexes
      .map((index) => NewPostData.gallery[index])
      .toList(growable: false);

  NewPostState copyWith({
    List<int>? selectedIndexes,
    int? previewIndex,
    String? caption,
    List<String>? hashtags,
    bool? hashtagsExpanded,
  }) {
    return NewPostState(
      selectedIndexes: selectedIndexes ?? this.selectedIndexes,
      previewIndex: previewIndex ?? this.previewIndex,
      caption: caption ?? this.caption,
      hashtags: hashtags ?? this.hashtags,
      hashtagsExpanded: hashtagsExpanded ?? this.hashtagsExpanded,
    );
  }

  @override
  List<Object> get props => [
    selectedIndexes,
    previewIndex,
    caption,
    hashtags,
    hashtagsExpanded,
  ];
}