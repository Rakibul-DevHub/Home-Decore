import 'dart:io';

import '../network_caller_dio.dart';

class ImageUploadService {
  ImageUploadService({
    required this.singleImageUploadUrl,
    required this.multipleImageUploadUrl,
    this.imageBaseUrl,
    NetworkCallerDio? networkCaller,
  }) : _networkCaller = networkCaller ?? NetworkCallerDio();

  final String singleImageUploadUrl;
  final String multipleImageUploadUrl;
  final String? imageBaseUrl;
  final NetworkCallerDio _networkCaller;

  Future<String?> uploadProfileImage(
    File imageFile, {
    String fileFieldName = 'image',
    Map<String, dynamic>? fields,
  }) async {
    final response = await _networkCaller.uploadImage(
      singleImageUploadUrl,
      imageFile: imageFile,
      body: fields,
      requiresAuth: true,
      fileFieldName: fileFieldName,
    );

    if (!response.isSuccess) {
      throw ImageUploadException(
        response.errorMessage ?? 'Failed to upload image',
      );
    }

    final path = _extractSingleUrl(response.data);
    return path == null ? null : _toAbsoluteUrl(path);
  }

  Future<List<String>> uploadMultipleImages(
    List<File> imageFiles, {
    String fileFieldName = 'images',
    Map<String, dynamic>? fields,
  }) async {
    final response = await _networkCaller.uploadMultipleImages(
      multipleImageUploadUrl,
      imageFiles: imageFiles,
      body: fields,
      requiresAuth: true,
      fileFieldName: fileFieldName,
    );

    if (!response.isSuccess) {
      throw ImageUploadException(
        response.errorMessage ?? 'Failed to upload images',
      );
    }

    return _extractMultipleUrls(
      response.data,
    ).map(_toAbsoluteUrl).toList(growable: false);
  }

  String? _extractSingleUrl(dynamic response) {
    if (response is! Map) {
      return null;
    }

    final data = response['data'];
    if (data is String) {
      return data;
    }
    if (data is Map) {
      final direct = data['imageUrl'] ?? data['url'];
      if (direct is String) {
        return direct;
      }

      final attributes = data['attributes'];
      if (attributes is Map) {
        final attributeUrl = attributes['imageUrl'] ?? attributes['url'];
        if (attributeUrl is String) {
          return attributeUrl;
        }

        final profileImage = attributes['profileImage'];
        if (profileImage is Map) {
          final profileUrl = profileImage['imageUrl'] ?? profileImage['url'];
          if (profileUrl is String) {
            return profileUrl;
          }
        }
      }
    }

    final direct = response['imageUrl'] ?? response['url'];
    return direct is String ? direct : null;
  }

  List<String> _extractMultipleUrls(dynamic response) {
    if (response is! Map) {
      return const [];
    }

    dynamic images = response['images'];
    final data = response['data'];
    if (images == null && data is Map) {
      images = data['images'];
      final attributes = data['attributes'];
      if (images == null && attributes is Map) {
        images = attributes['images'];
      }
    }

    if (images is! List) {
      return const [];
    }

    return images
        .map((image) {
          if (image is String) {
            return image;
          }
          if (image is Map) {
            final url = image['imageUrl'] ?? image['url'];
            return url is String ? url : null;
          }
          return null;
        })
        .whereType<String>()
        .toList(growable: false);
  }

  String _toAbsoluteUrl(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    final baseUrl = imageBaseUrl;
    if (baseUrl == null || baseUrl.isEmpty) {
      return path;
    }

    final normalizedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final normalizedPath = path.startsWith('/') ? path.substring(1) : path;
    return '$normalizedBase/$normalizedPath';
  }
}

class ImageUploadException implements Exception {
  const ImageUploadException(this.message);

  final String message;

  @override
  String toString() => message;
}
