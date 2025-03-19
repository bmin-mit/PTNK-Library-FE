import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          body: Text(pageIndex.toString()),
          bottomNavigationBar: NavigationBar(
            selectedIndex: pageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                selectedIcon: const Icon(Icons.home),
                icon: const Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.search),
                icon: const Icon(Icons.search_outlined),
                label: 'Search',
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.settings),
                icon: const Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
