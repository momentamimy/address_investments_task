import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../errors/failures.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> isConnected() async {
    List<ConnectivityResult> results = await connectivity.checkConnectivity();
    return results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.mobile);
  }
}

class NetworkService {
  final Dio _dioInstance = Dio();
  final bool withLogger;
  String? token;

  Dio get dio => _dioInstance;

  BaseOptions get dioOptions => _dioInstance.options;

  BaseOptions baseOptions = BaseOptions(
    method: 'Get',
    receiveDataWhenStatusError: true,
    receiveTimeout: const Duration(seconds: 120),
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    followRedirects: false,
    headers: {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "X-Accept-All-Languages": "True",
    },
  );

  NetworkService({this.withLogger = true}) {
    // Default base options:
    _dioInstance.options = baseOptions;
    addInterceptors();
  }

  void addInterceptors() {
    _dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException err, ErrorInterceptorHandler handler) async {
          return handler.next(err);
        },
      ),
    );

    if (withLogger) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 140,
        ),
      );
    }
  }

  static Failure handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return CustomFailure(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return CustomFailure(message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return CustomFailure(message: 'Receive timeout');
      case DioExceptionType.badCertificate:
        return CustomFailure(message: 'Invalid certificate');
      case DioExceptionType.badResponse:
        return CustomFailure(
            message:
            'Bad response: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      case DioExceptionType.cancel:
        return CustomFailure(message: 'Request canceled');
      case DioExceptionType.connectionError:
        return CustomFailure(message: 'Connection error');
      case DioExceptionType.unknown:
        return CustomFailure(message: 'Unknown error: ${e.message}');
    }
  }

}
