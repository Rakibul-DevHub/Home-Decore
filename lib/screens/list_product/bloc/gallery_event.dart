import 'package:equatable/equatable.dart';

sealed class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

/// Fired once when the picker is first shown.
final class GalleryLoadRequested extends GalleryEvent {
  const GalleryLoadRequested();
}

/// User tapped a photo to select or deselect it.
final class GalleryAssetToggled extends GalleryEvent {
  const GalleryAssetToggled(this.assetId);

  final String assetId;

  @override
  List<Object?> get props => [assetId];
}

/// User cleared the selection.
final class GallerySelectionCleared extends GalleryEvent {
  const GallerySelectionCleared();
}