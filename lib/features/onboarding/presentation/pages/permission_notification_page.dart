import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/helpers/permission_helper.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/features/onboarding/presentation/widgets/permission_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PermissionNotificationPage extends StatefulWidget {
  const PermissionNotificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _PermissionNotificationPageState();
}

class _PermissionNotificationPageState extends State<PermissionNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return PermissionWidget(
      imageName: 'img_onboarding_1',
      imageSub: 'Activate Your Notification',
      permissionTitle: "Request to Notification",
      permissionSubtitle: "Request notification to receive notification, chat detail & alice info.",
      onAllow: () => _onFunctionPermissionAllowed(context),
      onDeny: () => _onFunctionPermissionDeny(context),
    );
  }

  void _onFunctionPermissionAllowed(BuildContext context) async {
    prefInstance.setString(PrefsKey.isNotificationAllow.name, 'show');
    await PermissionHelper.requestNotificationPermissionHelpers();
    _nextAction(context);
  }

  void _onFunctionPermissionDeny(BuildContext context) async {
    prefInstance.setString(PrefsKey.isNotificationAllow.name, 'show');
    _nextAction(context);
  }

  void _nextAction(BuildContext context) async {
    final token = await storage.getAuthToken ?? '';

    if (token.isNotEmpty) {
      context.router.replaceAll([HomeRoute()]);
    } else {
      context.replaceRoute(const OnboardingRoute());
    }
  }
}
