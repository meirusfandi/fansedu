import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';

class DynamicLinkHelper {
  final _dynamicLinkInstance = FirebaseDynamicLinks.instance;

  Future<void> _handleRouteDeepLink(BuildContext? context, Uri deepLink) async {
    final _token = await storage.getAuthToken;
    final _isLoggedIn = _token?.isNotEmpty ?? false;
    deepLink.queryParameters.keys;
    if (context != null) {
      final page = deepLink.queryParameters['p'] ?? '';
      // if (sl<ProfileBloc>().state.userResponse == null) {
      //   sl<ProfileBloc>().add(const DataProfileUserEvent(isNeedUpdate: true));
      // }
      switch (page) {
        case 'fansedu-notification':
          if (_isLoggedIn) {
            context.router.replaceAll([HomeRoute(), NotificationRoute()]);
          } else {
            context.router.replaceAll([
              const OnboardingRoute(),
            ]);
          }
          break;
        case 'fansedu-profile':
          if (_isLoggedIn) {
            context.router.replaceAll([HomeRoute(), ProfileRoute()]);
          } else {
            context.router.replaceAll([
              const OnboardingRoute(),
            ]);
          }
          break;
        default:
          _isLoggedIn ? context.router.replaceAll([HomeRoute()]) : context.router.replaceAll([const OnboardingRoute()]);
          break;
      }
    }
  }

  Future handleDynamicLinks(GlobalKey<NavigatorState> navigatorKey) async {
    // 1. Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData? data = await _dynamicLinkInstance.getInitialLink();

    final context = navigatorKey.currentState?.context;
    // 2. handle link that has been retrieved
    _handleDeepLink(data, context);

    // 3. Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.

    _dynamicLinkInstance.onLink.listen((dynamicLink) {
      _handleDeepLink(dynamicLink, context);
    }, onError: (e) {
      debugPrint('Link Failed: $e');
    });
  }

  Future<void> _handleDeepLink(PendingDynamicLinkData? data, BuildContext? context) async {
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      deepLinkTrigger = deepLink;
      if (context != null) {
        _handleRouteDeepLink(context, deepLink);
      }
    }
  }
}

Uri? deepLinkTrigger;
