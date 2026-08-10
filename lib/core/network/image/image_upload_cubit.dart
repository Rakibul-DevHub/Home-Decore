import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_upload_service.dart';
import 'image_upload_state.dart';

class ImageUploadCubit extends Cubit<ImageUploadState> {
  ImageUploadCubit({required this.imageUploadService})
    : super(const ImageUploadState());

  final ImageUploadService imageUploadService;

  Future<void> uploadProfileImage(File imageFile) async {
    emit(const ImageUploadState.loading());
    try {
      final imageUrl = await imageUploadService.uploadProfileImage(imageFile);
      if (imageUrl == null || imageUrl.isEmpty) {
        emit(const ImageUploadState.failure('Image URL was not returned'));
        return;
      }
      emit(ImageUploadState.singleSuccess(imageUrl));
    } catch (error) {
      emit(ImageUploadState.failure(error.toString()));
    }
  }

  Future<void> uploadMultipleImages(List<File> imageFiles) async {
    emit(const ImageUploadState.loading());
    try {
      final imageUrls = await imageUploadService.uploadMultipleImages(
        imageFiles,
      );
      if (imageUrls.isEmpty) {
        emit(const ImageUploadState.failure('Image URLs were not returned'));
        return;
      }
      emit(ImageUploadState.multipleSuccess(imageUrls));
    } catch (error) {
      emit(ImageUploadState.failure(error.toString()));
    }
  }

  void clear() => emit(const ImageUploadState());
}
