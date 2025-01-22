import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/common/package_info_data.dart';
import 'package:fansedu/core/config/helpers/lang_config.dart';
import 'package:fansedu/core/helpers/data_helpers.dart';
import 'package:fansedu/core/helpers/firebase/notification_helper.dart';
import 'package:fansedu/core/helpers/firebase/remote_config.dart';
import 'package:fansedu/core/helpers/permission_helper.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/resources/injection_container.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:fansedu/generated/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..forward()
      ..addStatusListener((_) async {
        await initialProcess();
      });
  }

  Future<void> initialProcess() async {
    sl<RemoteConfigHelper>().reloadRemoteConfig();

    int remoteVersion = sl<RemoteConfigHelper>().getForceUpdateVersion ?? 0;
    int currentVersion = DataHelpers.getIntVersion(packageInfo.version ?? '');
    if (currentVersion != 0 && (remoteVersion > currentVersion)) {
      context.router.replaceAll([ForceUpdateRoute()]);
      return;
    } else {
      final token = await storage.getAuthToken;

      final isShowCamera = prefHelpers.getPermissionCamera;
      final isShowGallery = prefHelpers.getPermissionGallery;
      final isShowNotification = prefHelpers.getPermissionNotification;

      final isCameraGranted = await PermissionHelper.checkStatusPermissionCamera();
      final isGalleryGranted = await PermissionHelper.checkStatusPermissionPhotoGallery() || await PermissionHelper.checkStatusPermissionStorage();
      final isNotificationGranted = await PermissionHelper.checkStatusPermissionNotification();

      if (notificationResponse != null) {
        sl<NotificationHelper>().onTapNotification(notificationResponse: notificationResponse, context: context, token: token ?? '', language: LangConfig.instance.langValue, isFromLaunch: true);
        notificationResponse = null;
      } else if (!isCameraGranted && isShowCamera == null) {
        context.router.replaceAll([PermissionCameraRoute()]);
      } else if (!isGalleryGranted && isShowGallery == null) {
        context.router.replaceAll([PermissionGalleryRoute()]);
      } else if (!isNotificationGranted && isShowNotification == null) {
        context.router.replaceAll([PermissionNotificationRoute()]);
      } else if (token?.isNotEmpty ?? false){
        context.router.replaceAll([HomeRoute()]);
      } else {
        context.router.replaceAll([OnboardingRoute()]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CenterAlignedColumn(
                      children: [
                        Image.asset(
                          getSourceByPng('app_logo'),
                          height: 128,
                          width: 128,
                        ),
                        const CircularProgressIndicator(
                          color: ColorWidget.primaryColor,
                          strokeWidth: 8,
                          strokeAlign: 2,
                        ).topPadded(75),
                      ],
                    ),
                  ).topPadded(MediaQuery.of(context).size.height / 5),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: TextWidget.jakartaSansRegular(
                          S.of(context).general_app_version(packageInfo.version ?? ''),
                          size: 16,
                          color: ColorWidget.greyColor))
                      .bottomPadded(48),
                ],
              )),
        );
      }
    );
  }
}
