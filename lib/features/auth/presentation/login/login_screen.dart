import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ptnk_library_fe/core/routers/app_router.dart';
import 'package:ptnk_library_fe/features/auth/application/auth_notifier.dart';

import 'login_form.dart';

@RoutePage()
final class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.value != null) {
        context.router.replaceAll([const HomeRoute()]);
      }
    });

    return LoaderOverlay(child: Scaffold(body: Center(child: LoginForm())));
  }
}
