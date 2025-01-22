import 'package:auto_route/auto_route.dart';
import 'package:fansedu/features/about/pages/about_page.dart';
import 'package:fansedu/features/about/pages/help_center_page.dart';
import 'package:fansedu/features/about/pages/privacy_policy.dart';
import 'package:fansedu/features/about/pages/tnc_page.dart';
import 'package:fansedu/features/auth/pages/login_page.dart';
import 'package:fansedu/features/auth/pages/register_page.dart';
import 'package:fansedu/features/auth/pages/reset_password_page.dart';
import 'package:fansedu/features/chatroom/pages/chat_room_page.dart';
import 'package:fansedu/features/classroom/pages/classroom_detail_page.dart';
import 'package:fansedu/features/classroom/pages/classroom_enroll_page.dart';
import 'package:fansedu/features/classroom/pages/classroom_list_page.dart';
import 'package:fansedu/features/home/pages/dashboard_page.dart';
import 'package:fansedu/features/home/pages/home_page.dart';
import 'package:fansedu/features/notification/pages/notification_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/force_update_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/permission_camera_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/permission_gallery_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/permission_notification_page.dart';
import 'package:fansedu/features/onboarding/presentation/pages/splash_page.dart';
import 'package:fansedu/features/profile/pages/change_password_page.dart';
import 'package:fansedu/features/profile/pages/delete_account_page.dart';
import 'package:fansedu/features/profile/pages/edit_profile_page.dart';
import 'package:fansedu/features/profile/pages/profile_page.dart';
import 'package:fansedu/features/profile/pages/security_page.dart';
import 'package:permission_handler/permission_handler.dart';

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
    CustomRoute(
      children: [
        AutoRoute(page: ProfileRoute.page, path: 'profile-screen'),
        AutoRoute(page: DashboardRoute.page, path: 'dashboard-screen'),
        AutoRoute(page: ChatRoomRoute.page, path: 'chat-room-screen'),
      ],
      page: HomeRoute.page,
      path: '/home-screen',
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 300,
    ),
    AutoRoute(page: NotificationRoute.page, path: '/notification-screen'),
    AutoRoute(page: PrivacyPolicyRoute.page, path: '/privacy-policy-screen'),
    AutoRoute(page: TncRoute.page, path: '/tnc-screen'),
    AutoRoute(page: AboutRoute.page, path: '/about-screen'),
    AutoRoute(page: ClassRoomDetailRoute.page, path: '/class-room-detail-screen'),
    AutoRoute(page: ClassRoomEnrollRoute.page, path: '/class-room-enroll-screen'),
    AutoRoute(page: ClassRoomListRoute.page, path: '/class-room-list-screen'),
    AutoRoute(page: PermissionCameraRoute.page, path: '/permission-camera-screen'),
    AutoRoute(page: PermissionGalleryRoute.page, path: '/permission-gallery-screen'),
    AutoRoute(page: PermissionNotificationRoute.page, path: '/permission-notification-screen'),
    AutoRoute(page: ForceUpdateRoute.page, path: '/force-update-screen'),
    AutoRoute(page: EditProfileRoute.page, path: '/edit-profile-screen'),
    AutoRoute(page: HelpCenterRoute.page, path: '/help-center-screen'),
    AutoRoute(page: ChangePasswordRoute.page, path: '/change-password-screen'),
    AutoRoute(page: DeleteAccountRoute.page, path: '/delete-account-screen'),
    AutoRoute(page: SecurityRoute.page, path: '/security-screen')
  ];
}

class $AppRouter {}