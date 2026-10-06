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