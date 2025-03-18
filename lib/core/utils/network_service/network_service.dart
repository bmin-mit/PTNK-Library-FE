import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/api.dart';

part 'network_service.g.dart';

@riverpod
Dio networkService(Ref ref) {
  return Dio(BaseOptions(baseUrl: apiBasePath))
    ..interceptors.add(CurlLoggerDioInterceptor());
}
