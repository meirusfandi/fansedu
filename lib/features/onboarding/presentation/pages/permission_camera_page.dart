import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/helpers/permission_helper.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/features/onboarding/presentation/widgets/permission_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PermissionCameraPage extends StatefulWidget {
  const PermissionCameraPage({super.key});

  @override
  State<StatefulWidget> createState() => _PermissionCameraPageState();
}

class _PermissionCameraPageState extends State<PermissionCameraPage> {
  @override
  Widget build(BuildContext context) {
    return PermissionWidget(
      imageName: 'img_onboarding_3',
      imageSub: 'Activate Your Camera',
      permissionTitle: "Request activate Camera",
      permissionSubtitle: "Request Camera for update profile picture.",
      onAllow: () => _onFunctionPermissionAllowed(context),
      onDeny: () => _onFunctionPermissionDeny(context),
    );
  }

  void _onFunctionPermissionAllowed(BuildContext context) async {
    prefInstance.setString(PrefsKey.isCameraAllow.name, 'show');
    await PermissionHelper.requestCameraPermissionHelpers();
    _nextAction(context);
  }

  void _onFunctionPermissionDeny(BuildContext context) async {
    prefInstance.setString(PrefsKey.isCameraAllow.name, 'show');
    _nextAction(context);
  }

  void _nextAction(BuildContext context) async {
    final token = await storage.getAuthToken ?? '';
    final isShowGallery = prefHelpers.getPermissionGallery;
    final isShowNotification = prefHelpers.getPermissionNotification;

    final isGalleryGranted = await PermissionHelper.checkStatusPermissionPhotoGallery() || await PermissionHelper.checkStatusPermissionStorage();
    final isNotificationGranted = await PermissionHelper.checkStatusPermissionNotification();

    if (!isGalleryGranted && isShowGallery == null) {
      context.router.replaceAll([PermissionGalleryRoute()]);
      return;
    }

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
