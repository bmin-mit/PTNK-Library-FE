import 'package:ptnk_library_fe/core/utils/network_service/network_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/core/constants/api.dart';
import '../domain/user_token.dart';

part 'auth_repository.g.dart';

@riverpod
class AuthRepository extends _$AuthRepository {
  @override
  void build() {}

  Future<UserToken> login({
    required String username,
    required String password,
  }) async {
    final dio = ref.watch(networkServiceProvider);

    final response = await dio.post(
      loginPath,
      data: {"username": username, "password": password},
    );

    final userToken = UserToken.fromJson(response.data);

    dio.options.headers['Authorization'] =
        '${userToken.tokenType} ${userToken.accessToken}';

    return userToken;
  }
}
