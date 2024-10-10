import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'cashed_helper.dart';


class DioHelper {
  final Dio dio;

  DioHelper()
      : dio = Dio(BaseOptions(
    baseUrl: "https://todo.iraqsapp.com/",
  )) {
    dio.interceptors.add(AuthInterceptor(dio));
  }

  Map<String, dynamic> _buildHeaders({bool haveToken = false}) {
    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (haveToken) {
      headers["Authorization"] = "Bearer ${CachedHelper.getToken()}";
    }
    return headers;
  }

  Future<CustomResponse> sendData({
    required String endPoint,
    Object? data,
    bool haveToken = false,
  }) async {
    try {
      final response = await dio.post(
        endPoint,
        data: data,
        options: Options(headers: _buildHeaders(haveToken: haveToken)),
      );
      debugPrint('$endPoint is Success: ${response.data}');
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data['message'] ?? 'Success',
      );
    } on DioException catch (e) {
      debugPrint('*' * 50);
      debugPrint('$endPoint is Error: ${e.response?.data}');
      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'] ?? 'Network Error',
      );
    }
  }

  Future<CustomResponse> updateData({
    required String endPoint,
    Map<String, dynamic>? data,
    bool haveToken = false,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: data,
        options: Options(headers: _buildHeaders(haveToken: haveToken)),
      );
      debugPrint('$endPoint is Success: ${response.data}');
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data['message'] ?? 'Success',
      );
    } on DioException catch (e) {
      debugPrint('*' * 50);
      debugPrint('$endPoint is Error: ${e.response?.data}');
      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'] ?? 'Network Error',
      );
    }
  }

  Future<CustomResponse> getData({
    required String endPoint,
    Map<String, dynamic>? data,
    bool haveToken = false,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: data,
        options: Options(headers: _buildHeaders(haveToken: haveToken)),
      );
      debugPrint('$endPoint is Success: ${response.data}');
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data.toString(),
      );
    } on DioException catch (e) {
      debugPrint('$endPoint is Error: ${e.response?.data}');
      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'] ?? 'Error',
      );
    }
  }

  Future<CustomResponse> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    bool haveToken = false,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        queryParameters: data,
        options: Options(headers: _buildHeaders(haveToken: haveToken)),
      );
      debugPrint('$endPoint is Success: ${response.data}');
      return CustomResponse(
        response: response,
        isSuccess: true,
        message: response.data['message'] ?? 'Success',
      );
    } on DioException catch (e) {
      debugPrint('$endPoint is Error: ${e.response?.data}');
      return CustomResponse(
        response: e.response,
        isSuccess: false,
        message: e.response?.data['message'] ?? 'Error',
      );
    }
  }
}

class CustomResponse {
  final Response? response;
  final String message;
  final bool isSuccess;

  CustomResponse({
    this.response,
    required this.isSuccess,
    required this.message,
  });
}

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (kDebugMode) {
        print("AuthInterceptor");
      }

      // Attempt to refresh the token
      try {
        final newToken = await refreshAuthToken();
        if (newToken != null) {
          // If token is refreshed, update it in the headers
          err.requestOptions.headers["Authorization"] = "Bearer $newToken";
          // Resend the request
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        debugPrint("Token refresh error: $e");
      }
    }
    super.onError(err, handler);
  }

  Future<String?> refreshAuthToken() async {
    print("refreshAuthToken");
    print('${dio.options.baseUrl}auth/refresh-token?token=${CachedHelper.getRefreshToken()}');
    final response = await dio.get('${dio.options.baseUrl}auth/refresh-token?token=${CachedHelper.getRefreshToken()}');
    print("refreshAuthToken");
    if (response.statusCode == 200) {
      print("="*500);
      print("refreshAuthToken is worked");
      print("="*500);
      final newToken = response.data['access_token'];
      CachedHelper.saveData(
        token: newToken,
        id: CachedHelper.getId(),
        refreshToken: CachedHelper.getRefreshToken(),
      );
      return newToken;
    }
    return null;
  }
}
