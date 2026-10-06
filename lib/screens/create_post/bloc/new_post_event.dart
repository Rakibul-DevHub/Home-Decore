// import 'package:equatable/equatable.dart';
//
// sealed class NewPostEvent extends Equatable {
//   const NewPostEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// /// User tapped an image in the gallery grid to toggle its selection.
// final class NewPostImageToggled extends NewPostEvent {
//   const NewPostImageToggled(this.index);
//
//   final int index;
//
//   @override
//   List<Object?> get props => [index];
// }
//
// /// User tapped an image to preview it in the large hero slot.
// final class NewPostPreviewSet extends NewPostEvent {
//   const NewPostPreviewSet(this.index);
//
//   final int index;
//
//   @override
//   List<Object?> get props => [index];
// }
//
// /// User tapped the ✕ on a selected thumbnail in the details screen.
// final class NewPostImageRemoved extends NewPostEvent {
//   const NewPostImageRemoved(this.galleryIndex);
//
//   final int galleryIndex;
//
//   @override
//   List<Object?> get props => [galleryIndex];
// }
//
// /// User edited the caption.
// final class NewPostCaptionChanged extends NewPostEvent {
//   const NewPostCaptionChanged(this.value);
//
//   final String value;
//
//   @override
//   List<Object?> get props => [value];
// }









import 'package:equatable/equatable.dart';

sealed class NewPostEvent extends Equatable {
  const NewPostEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped an image in the gallery grid to toggle its selection.
final class NewPostImageToggled extends NewPostEvent {
  const NewPostImageToggled(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

/// User tapped an image to preview it in the large hero slot.
final class NewPostPreviewSet extends NewPostEvent {
  const NewPostPreviewSet(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

/// User tapped the ✕ on a selected thumbnail in the details screen.
final class NewPostImageRemoved extends NewPostEvent {
  const NewPostImageRemoved(this.galleryIndex);

  final int galleryIndex;

  @override
  List<Object?> get props => [galleryIndex];
}

/// User edited the caption.
final class NewPostCaptionChanged extends NewPostEvent {
  const NewPostCaptionChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User tapped the "Add Hashtags" row to open/close the hashtag input.
final class NewPostHashtagsToggled extends NewPostEvent {
  const NewPostHashtagsToggled();
}

/// User added a hashtag.
final class NewPostHashtagAdded extends NewPostEvent {
  const NewPostHashtagAdded(this.tag);

  /// Raw tag text from the input field. May include a leading '#'.
  final String tag;

  @override
  List<Object?> get props => [tag];
}

/// User removed a hashtag (tapped the ✕ on a chip).
final class NewPostHashtagRemoved extends NewPostEvent {
  const NewPostHashtagRemoved(this.tag);

  final String tag;

  @override
  List<Object?> get props => [tag];
}