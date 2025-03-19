import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptnk_library_fe/core/routers/guards/auth_guard.dart';
import 'package:ptnk_library_fe/features/auth/presentation/login/login_screen.dart';
import 'package:ptnk_library_fe/features/home/presentation/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  final WidgetRef ref;

  AppRouter(this.ref);

  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true, guards: [AuthGuard(ref)]),
    AutoRoute(page: LoginRoute.page),
  ];
}
