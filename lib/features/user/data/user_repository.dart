import 'package:ptnk_library_fe/core/constants/api.dart';
import 'package:ptnk_library_fe/core/utils/network_service/network_service.dart';
import 'package:ptnk_library_fe/features/auth/application/auth_notifier.dart';
import 'package:ptnk_library_fe/features/user/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

@riverpod
class UserRepository extends _$UserRepository {
  @override
  User? build() {
    getProfile();

    return state;
  }

  Future<User?> getProfile() async {
    final userToken = ref.watch(authNotifierProvider).value;
    final dio = ref.watch(networkServiceProvider);

    if (userToken == null) return null;

    final response = await dio.get(getMePath);
    final user = User.fromJson(response.data);
    state = user;
    return user;
  }
}
