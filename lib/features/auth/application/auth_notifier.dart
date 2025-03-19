import 'package:ptnk_library_fe/features/auth/data/auth_repository.dart';
import 'package:ptnk_library_fe/features/auth/domain/user_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
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
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
