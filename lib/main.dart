import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/features/home/presentation/home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  final _seedColor = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PTNK Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _seedColor),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
