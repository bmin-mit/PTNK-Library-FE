import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class _AuthTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  _AuthTextInput({
    TextEditingController? controller,
    this.labelText,
    this.obscureText,
    this.keyboardType,
    this.validator,
  }) : controller = controller ?? TextEditingController();

  @override
  State<_AuthTextInput> createState() => _AuthTextInputState();
}

class _AuthTextInputState extends State<_AuthTextInput> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        return TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon:
                widget.controller.text.isNotEmpty
                    ? IconButton(
                      onPressed: widget.controller.clear,
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

final class PasswordInput extends StatelessWidget {
  final TextEditingController? controller;

  const PasswordInput({super.key, this.controller});

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _AuthTextInput(
      controller: controller,
      labelText: 'Password',
      obscureText: true,
      validator: validator,
    );
  }
}

final class UsernameInput extends StatelessWidget {
  final TextEditingController? controller;

  const UsernameInput({super.key, this.controller});

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _AuthTextInput(
      controller: controller,
      labelText: 'Username',
      validator: validator,
    );
  }
}

final class EmailInput extends StatelessWidget {
  final TextEditingController? controller;

  const EmailInput({super.key, this.controller});

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (!EmailValidator.validate(value)) {
      return 'Invalid email';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _AuthTextInput(
      controller: controller,
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      validator: validator,
    );
  }
}
