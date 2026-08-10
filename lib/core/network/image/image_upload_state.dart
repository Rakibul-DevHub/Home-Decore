import 'package:equatable/equatable.dart';

class ImageUploadState extends Equatable {
  const ImageUploadState({
    this.isLoading = false,
    this.imageUrl,
    this.imageUrls = const [],
    this.errorMessage,
    this.isSuccess = false,
  });

  final bool isLoading;
  final String? imageUrl;
  final List<String> imageUrls;
  final String? errorMessage;
  final bool isSuccess;

  const ImageUploadState.loading()
    : isLoading = true,
      imageUrl = null,
      imageUrls = const [],
      errorMessage = null,
      isSuccess = false;

  const ImageUploadState.failure(String message)
    : isLoading = false,
      imageUrl = null,
      imageUrls = const [],
      errorMessage = message,
      isSuccess = false;

  const ImageUploadState.singleSuccess(String url)
    : isLoading = false,
      imageUrl = url,
      imageUrls = const [],
      errorMessage = null,
      isSuccess = true;

  const ImageUploadState.multipleSuccess(List<String> urls)
    : isLoading = false,
      imageUrl = null,
      imageUrls = urls,
      errorMessage = null,
      isSuccess = true;

  @override
  List<Object?> get props => [
    isLoading,
    imageUrl,
    imageUrls,
    errorMessage,
    isSuccess,
  ];
}
