import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

typedef OnSaveNewTokens =
    Future<void> Function({
      required String refreshToken,
      required String accessToken,
    });
typedef OnUnauthorized = Future Function();

typedef OnSaveNewAuth = Future Function(Map<String, dynamic> responseUerModel);

class RestApiSource {
  final Dio _dio;

  Dio get dio => _dio;

  final TalkerDioLogger dioTalker = TalkerDioLogger(
    settings: const TalkerDioLoggerSettings(
      // All http responses enabled for console logging
      printResponseData: true,
      // All http requests disabled for console logging
      printRequestData: true,
      // Reposnse logs including http - headers
      printResponseHeaders: false,
      // Request logs without http - headersa
      printRequestHeaders: true,
    ),
  );

  // Constructor
  RestApiSource({
    required String baseUrl,
    Map<String, dynamic>? headers,
    String? token,
    Dio? dio,
    OnSaveNewTokens? onSaveNewTokens,
    OnUnauthorized? onUnauthorized,
    OnSaveNewAuth? onSaveNewAuth,
  }) : _dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl,
               headers: headers ?? {'Content-Type': 'application/json'},
               connectTimeout: Duration(seconds: 10), // 10 seconds
               receiveTimeout: Duration(seconds: 10), // 10 seconds
             ),
           ) {
    // You can add interceptors here if needed
    _dio.interceptors.add(dioTalker);

    // setAuthorizationToken(token);

    // _dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler) async {
    //       if (options.path.contains('api/auth/logout')) {
    //         talker.info('Log Out');
    //         return;
    //       }
    //       Retrieve the token from secure storage.
    // return handler.next(options);
    // },
    // onError: (err, handler) async {},
    // ),
    // );
  }

  // Generic GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues, timeouts)
      log('DioException in GET request to $path: ${e.message}');
      rethrow;
    } catch (e) {
      // Handle other errors
      log('Unexpected error in GET request to $path: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Generic POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      log('DioException in POST request to $path: ${e.message}');
      rethrow;
    } catch (e) {
      log('Unexpected error in POST request to $path: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Generic PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e, stackTrace) {
      log(
        'DioException in PUT request to $path: ${e.message}',
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (e) {
      log('Unexpected error in PUT request to $path: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Generic DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      log('DioException in DELETE request to $path: ${e.message}');
      rethrow;
    } catch (e) {
      log('Unexpected error in DELETE request to $path: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      log('DioException in PATCH request to $path: ${e.message}');
      rethrow;
    } catch (e) {
      log('Unexpected error in PATCH request to $path: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Helper method to handle Dio errors and throw more specific exceptions

  /// Updates the authorization token in the Dio instance's headers.
  ///
  /// Call this method after the user logs in or when the token is refreshed.
  void setAuthorizationToken(String? token) {
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      dio.options.headers.remove('Authorization');
    }
  }

  void setContentTypeMultipartFormData() {
    dio.options.headers['Content-Type'] = 'multipart/form-data';
  }

  void removeContentTypeMultipartFormData() {
    dio.options.headers['Content-Type'] = 'application/json';
  }

  /// Clears the authorization token from the Dio instance's headers.
  ///
  /// Call this method when the user logs out.
  void clearAuthorizationToken() {
    dio.options.headers.remove('Authorization');
  }

  /// Allows adding custom interceptors to the Dio instance.
  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }
}
