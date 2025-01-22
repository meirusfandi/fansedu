import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/helpers/permission_helper.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/features/onboarding/presentation/widgets/permission_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PermissionGalleryPage extends StatefulWidget {
  const PermissionGalleryPage({super.key});

  @override
  State<StatefulWidget> createState() => _PermissionGalleryPageState();
}

class _PermissionGalleryPageState extends State<PermissionGalleryPage> {
  @override
  Widget build(BuildContext context) {
    return PermissionWidget(
      imageName: 'img_onboarding_2',
      imageSub: 'Activate Your Gallery',
      permissionTitle: "Request activate Gallery",
      permissionSubtitle: "Request gallery to update profile picture & take image from gallery to submit answer on quiz/assignments.",
      onAllow: () => _onFunctionPermissionAllowed(context),
      onDeny: () => _onFunctionPermissionDeny(context),
    );
  }

  void _onFunctionPermissionAllowed(BuildContext context) async {
    prefInstance.setString(PrefsKey.isGalleryAllow.name, 'show');
    await PermissionHelper.requestPhotoGalleryPermissionHelpers();
    _nextAction(context);
  }

  void _onFunctionPermissionDeny(BuildContext context) async {
    prefInstance.setString(PrefsKey.isGalleryAllow.name, 'show');
    _nextAction(context);
  }

  void _nextAction(BuildContext context) async {
    final token = await storage.getAuthToken ?? '';
    final isShowNotification = prefHelpers.getPermissionNotification;

    final isNotificationGranted = await PermissionHelper.checkStatusPermissionNotification();

    if (!isNotificationGranted && isShowNotification == null) {
      context.router.replaceAll([PermissionNotificationRoute()]);
      return;
    }

    if (token.isNotEmpty) {
      context.router.replaceAll([HomeRoute()]);
    } else {
      context.replaceRoute(const OnboardingRoute());
    }
  }
}
