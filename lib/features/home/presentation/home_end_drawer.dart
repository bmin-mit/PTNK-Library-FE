import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptnk_library_fe/features/user/application/user_notifier.dart';

class HomeEndDrawer extends ConsumerWidget {
  const HomeEndDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);

    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline, size: 40),
                  SizedBox(width: 16),
                  Text(
                    user.valueOrNull?.name ?? "username",
                    style: TextTheme.of(context).titleLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
