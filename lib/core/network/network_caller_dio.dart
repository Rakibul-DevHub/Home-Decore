import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mime/mime.dart';

import 'network_response_dio.dart';
import 'secure_storage_service.dart';

class NetworkCallerDio {
  NetworkCallerDio({Dio? dio, SecureStorageService? storage, String? baseUrl})
    : _storage = storage ?? SecureStorageService.instance,
      _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl ?? '',
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),
              validateStatus: (status) =>
                  status != null && status >= 200 && status < 600,
            ),
          );

  final Dio _dio;
  final SecureStorageService _storage;

  Future<NetworkResponseDio> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requiresAuth = false,
    CancelToken? cancelToken,
  }) {
    return _request(
      'GET',
      url,
      queryParameters: queryParameters,
      headers: headers,
      requiresAuth: requiresAuth,
      cancelToken: cancelToken,
    );
  }

  Future<NetworkResponseDio> postRequest(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requiresAuth = false,
    CancelToken? cancelToken,
  }) {
    return _request(
      'POST',
      url,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      requiresAuth: requiresAuth,
      cancelToken: cancelToken,
    );
  }

  Future<NetworkResponseDio> putRequest(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requiresAuth = false,
    CancelToken? cancelToken,
  }) {
    return _request(
      'PUT',
      url,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      requiresAuth: requiresAuth,
      cancelToken: cancelToken,
    );
  }

  Future<NetworkResponseDio> patchRequest(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requiresAuth = false,
    CancelToken? cancelToken,
  }) {
    return _request(
      'PATCH',
      url,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      requiresAuth: requiresAuth,
      cancelToken: cancelToken,
    );
  }

  Future<NetworkResponseDio> deleteRequest(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requiresAuth = false,
    CancelToken? cancelToken,
  }) {
    return _request(
      'DELETE',
      url,
      body: body,
      queryParameters: queryParameters,
      headers: headers,
      requiresAuth: requiresAuth,
      cancelToken: cancelToken,
    );
  }

  Future<NetworkResponseDio> uploadImage(
    String url, {
    required File imageFile,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = true,
    String fileFieldName = 'image',
    String method = 'POST',
    ProgressCallback? onProgress,
    CancelToken? cancelToken,
  }) {
    return uploadMultipleImages(
      url,
      imageFiles: [imageFile],
      body: body,
      headers: headers,
      requiresAuth: requiresAuth,
      fileFieldName: fileFieldName,
      indexedFieldNames: false,
      method: method,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );
  }

  Future<NetworkResponseDio> uploadMultipleImages(
    String url, {
    required List<File> imageFiles,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool requiresAuth = true,
    String fileFieldName = 'images',
    bool indexedFieldNames = true,
    String method = 'POST',
    ProgressCallback? onProgress,
    CancelToken? cancelToken,
  }) async {
    if (imageFiles.isEmpty) {
      return const NetworkResponseDio(
        isSuccess: false,
        errorMessage: 'No image files selected',
      );
    }

    final formData = FormData();
    body?.forEach((key, value) {
      if (value != null) {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    for (var index = 0; index < imageFiles.length; index++) {
      final file = imageFiles[index];
      if (!await file.exists()) {
        return NetworkResponseDio(
          isSuccess: false,
          errorMessage: 'Image file does not exist: ${file.path}',
        );
      }

      final fileName = file.uri.pathSegments.last;
      final contentType = lookupMimeType(fileName);
      formData.files.add(
        MapEntry(
          indexedFieldNames ? '$fileFieldName[$index]' : fileFieldName,
          await MultipartFile.fromFile(
            file.path,
            filename: fileName,
            contentType: contentType == null
                ? null
                : DioMediaType.parse(contentType),
          ),
        ),
      );
    }

    return _request(
      method.toUpperCase(),
      url,
      body: formData,
      headers: headers,
      requiresAuth: requiresAuth,
      contentType: 'multipart/form-data',
      onSendProgress: onProgress,
      cancelToken: cancelToken,
    );
  }

  Future<NetworkResponseDio> _request(
    String method,
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool requiresAuth = false,
    String contentType = 'application/json',
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final requestHeaders = <String, String>{...?headers};
      if (requiresAuth && !requestHeaders.containsKey('Authorization')) {
        final token = await _storage.getAccessToken();
        if (token == null || token.isEmpty) {
          return const NetworkResponseDio(
            isSuccess: false,
            statusCode: 401,
            errorMessage: 'Authentication required',
          );
        }
        requestHeaders['Authorization'] = 'Bearer $token';
      }

      debugPrint('HTTP $method $url');
      final response = await _dio.request<dynamic>(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: requestHeaders,
          contentType: contentType,
        ),
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
      debugPrint('HTTP ${response.statusCode} $method $url');
      return _handleResponse(response);
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) {
        return const NetworkResponseDio(
          isSuccess: false,
          errorMessage: 'Request cancelled',
        );
      }
      if (error.response != null) {
        return _handleResponse(error.response!);
      }
      return NetworkResponseDio(
        isSuccess: false,
        errorMessage: _dioErrorMessage(error),
      );
    } catch (error) {
      return NetworkResponseDio(
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  NetworkResponseDio _handleResponse(Response<dynamic> response) {
    final statusCode = response.statusCode;
    final success = statusCode != null && statusCode >= 200 && statusCode < 300;

    return NetworkResponseDio(
      statusCode: statusCode,
      isSuccess: success,
      data: response.data,
      errorMessage: success ? null : _extractErrorMessage(response.data),
    );
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map) {
      final message = data['message'] ?? data['error'];
      if (message != null) {
        return message.toString();
      }

      final errors = data['errors'];
      if (errors is Map) {
        return errors.values.join(', ');
      }
      if (errors is List) {
        return errors.join(', ');
      }
    }
    return 'Request failed';
  }

  String _dioErrorMessage(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout => 'Connection timed out',
      DioExceptionType.sendTimeout => 'Request timed out',
      DioExceptionType.receiveTimeout => 'Response timed out',
      DioExceptionType.connectionError => 'Unable to connect to the server',
      DioExceptionType.badCertificate => 'Invalid server certificate',
      _ => error.message ?? 'Network request failed',
    };
  }
}
