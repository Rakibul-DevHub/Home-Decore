import 'package:equatable/equatable.dart';

sealed class ListProductEvent extends Equatable {
  const ListProductEvent();

  @override
  List<Object?> get props => [];
}

/// User added a photo. [path] is the file path returned by the gallery
/// picker. When null, the bloc falls back to a sample asset (demo only).
final class ListProductPhotoAdded extends ListProductEvent {
  const ListProductPhotoAdded({this.path});

  final String? path;

  @override
  List<Object?> get props => [path];
}

/// User removed a photo from the row.
final class ListProductPhotoRemoved extends ListProductEvent {
  const ListProductPhotoRemoved(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class ListProductTitleChanged extends ListProductEvent {
  const ListProductTitleChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductArtistChanged extends ListProductEvent {
  const ListProductArtistChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductYearChanged extends ListProductEvent {
  const ListProductYearChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductCategoryChanged extends ListProductEvent {
  const ListProductCategoryChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductWidthChanged extends ListProductEvent {
  const ListProductWidthChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductHeightChanged extends ListProductEvent {
  const ListProductHeightChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User tapped Next.
final class ListProductSubmitted extends ListProductEvent {
  const ListProductSubmitted();
}

/// User tapped Save as Draft.
final class ListProductDraftSaved extends ListProductEvent {
  const ListProductDraftSaved();
}