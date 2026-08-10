import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class ImageUploadEvent extends Equatable {
  const ImageUploadEvent();

  @override
  List<Object?> get props => const [];
}

final class UploadProfileImage extends ImageUploadEvent {
  const UploadProfileImage(this.imageFile);

  final File imageFile;

  @override
  List<Object?> get props => [imageFile];
}

final class UploadMultipleImages extends ImageUploadEvent {
  const UploadMultipleImages(this.imageFiles);

  final List<File> imageFiles;

  @override
  List<Object?> get props => [imageFiles];
}

final class ClearImageUploadState extends ImageUploadEvent {
  const ClearImageUploadState();
}
