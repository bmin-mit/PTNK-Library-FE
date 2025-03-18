import 'package:flutter/material.dart';

class AuthTextInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  AuthTextInput({
    super.key,
    TextEditingController? controller,
    this.labelText,
    this.obscureText,
    this.keyboardType,
    this.validator,
  }) : controller = controller ?? TextEditingController();

  @override
  State<AuthTextInput> createState() => _AuthTextInputState();
}

class _AuthTextInputState extends State<AuthTextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, child) {
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon:
                _controller.text.isNotEmpty
                    ? IconButton(
                      onPressed: _controller.clear,
                      icon: const Icon(Icons.cancel_outlined),
                    )
                    : null,
          ),
          obscureText: widget.obscureText ?? false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  final TextEditingController? controller;

  const PasswordInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return AuthTextInput(
      controller: controller,
      labelText: 'Password',
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  final TextEditingController? controller;

  const EmailInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return AuthTextInput(
      controller: controller,
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }
}
