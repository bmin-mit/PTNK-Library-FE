import 'package:ptnk_library_fe/features/user/data/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/user.dart';

part 'user_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  AsyncValue<User?> build() {
    return state;
  }

  Future<void> getCurrentProfile() async {
    final userRepository = ref.watch(userRepositoryProvider.notifier);

    try {
      state = AsyncValue.loading();
      final profile = await userRepository.getProfile();
      state = AsyncData(profile);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
