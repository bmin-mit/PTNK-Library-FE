import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptnk_library_fe/features/auth/application/auth_notifier.dart';

import '../app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final WidgetRef ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final userToken = ref.read(authNotifierProvider);

    if (userToken.valueOrNull != null) {
      resolver.next(true);
    } else {
      if (router.current is! LoginRoute) {
        router.replace(const LoginRoute());
      }
    }
  }
}
