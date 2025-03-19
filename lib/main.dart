import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routers/app_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  App({super.key});

  final _seedColor = Colors.pink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'PTNK Library',
      routerConfig: AppRouter(ref).config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
        useMaterial3: true,
      ),
    );
  }
}
