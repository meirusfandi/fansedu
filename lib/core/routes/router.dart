import 'package:auto_route/auto_route.dart';
import 'package:fansedu/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/splash_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: OnboardingRoute.page, path: 'onboarding-screen'),
  ];
}

class $AppRouter {}