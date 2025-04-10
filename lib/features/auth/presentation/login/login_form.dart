import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../application/auth_notifier.dart';
import '../auth_text_input.dart';

final class LoginForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = Provider.autoDispose<TextEditingController>((
    ref,
  ) {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);

    return controller;
  });

  final _passwordController = Provider.autoDispose<TextEditingController>((
    ref,
  ) {
    final controller = TextEditingController();
    ref.onDispose(controller.dispose);

    return controller;
  });

  LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.isLoading) {
        context.loaderOverlay.show();
        return;
      }

      context.loaderOverlay.hide();

      if (next.hasError) {
        final error = next.error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

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

  bool _validateForm() {
    return _formKey.currentState!.validate();
  }

  void _submitLoginRequest(BuildContext context, WidgetRef ref) {
    if (!_validateForm()) {
      return;
    }

    ref
        .read(authNotifierProvider.notifier)
        .login(
          username: ref.watch(_usernameController).text,
          password: ref.watch(_passwordController).text,
        );
  }
}
