import 'package:dio/dio.dart';
import 'package:ptnk_library_fe/features/auth/data/auth_repository.dart';
import 'package:ptnk_library_fe/features/auth/domain/user_token.dart';
import 'package:ptnk_library_fe/features/user/application/user_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<UserToken?> build() {
    return null;
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final userToken = await ref
          .read(authRepositoryProvider.notifier)
          .login(username: username, password: password);

      state = AsyncValue.data(userToken);

      final userNotifier = ref.read(userNotifierProvider.notifier);
      userNotifier.getCurrentProfile();
    } on DioException catch (e, stackTrace) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          state = AsyncValue.error(
            "Connection failure or server is down, please check your network connection!",
            stackTrace,
          );
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          state = AsyncValue.error(
            "Connection timeout, please try again later!",
            stackTrace,
          );
        case DioExceptionType.badResponse:
          if (e.response?.statusCode == 400) {
            state = AsyncValue.error(
              "Invalid username or password!",
              stackTrace,
            );
          }

        default:
          state = AsyncValue.error("Unknown error.", stackTrace);
      }
    }
  }
}
