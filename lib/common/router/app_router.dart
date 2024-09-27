import 'package:auto_route/auto_route.dart';
import 'package:outlay/features/start/splash/splash_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),

  ];
}
