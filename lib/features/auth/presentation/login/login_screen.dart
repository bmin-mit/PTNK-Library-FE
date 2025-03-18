import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth_service.dart';
import 'login_form.dart';

final class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userToken = ref.watch(authServiceProvider).value;

    if (userToken != null) {
      Future.microtask(() => Navigator.pop(context));
    }

    return Scaffold(body: Center(child: LoginForm()));
  }
}
