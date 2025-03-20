import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptnk_library_fe/core/constants/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_service.g.dart';

final dio = Dio(BaseOptions(baseUrl: apiBasePath));

@Riverpod(keepAlive: true)
Dio networkService(Ref ref) {
  return dio;
}
