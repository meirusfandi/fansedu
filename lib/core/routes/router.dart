import 'package:auto_route/auto_route.dart';
import 'package:fansedu/features/auth/pages/login_page.dart';
import 'package:fansedu/features/auth/pages/register_page.dart';
import 'package:fansedu/features/auth/pages/reset_password_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/splash_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: OnboardingRoute.page, path: '/onboarding-screen'),
    AutoRoute(page: LoginRoute.page, path: '/login-screen'),
    AutoRoute(page: RegisterRoute.page, path: '/register-screen'),
    AutoRoute(page: ResetPasswordRoute.page, path: '/reset-password-screen'),
  ];
}

class $AppRouter {}