import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth_service.dart';
import '../auth_text_input.dart';

final class LoginForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = Provider.autoDispose<TextEditingController>((
    ref,
  ) {
    final controller = TextEditingController();
    ref.onDispose(() {
      controller.dispose();
    });

    return controller;
  });

  final _passwordController = Provider.autoDispose<TextEditingController>((
    ref,
  ) {
    final controller = TextEditingController();
    ref.onDispose(() {
      controller.dispose();
    });

    return controller;
  });

  LoginForm({super.key});

  bool _validateForm() {
    return _formKey.currentState!.validate();
  }

  void _submitLoginRequest(BuildContext context, WidgetRef ref) {
    if (!_validateForm()) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Logging in...')));

    ref
        .read(authServiceProvider.notifier)
        .login(
          username: ref.watch(_usernameController).text,
          password: ref.watch(_passwordController).text,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      margin: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UsernameInput(controller: ref.watch(_usernameController)),
            const SizedBox(height: 8),
            PasswordInput(controller: ref.watch(_passwordController)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => _submitLoginRequest(context, ref),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
