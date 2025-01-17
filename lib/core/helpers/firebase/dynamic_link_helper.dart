import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/flavor/flavor_config.dart';
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
      if (deepLink.queryParameters.containsKey('doctorID')) {
        // final jsonString = deepLink.queryParameters['doctorID'];
        // final nakesEntity = DatumNakesEntity.fromJson(jsonDecode(jsonString ?? ''));
        // _isLoggedIn
        //     ? context.router.replaceAll([HomeRoute(), DoctorInformationDetailRoute(nakesEntity: nakesEntity, isFromLink: true, sourceType: HomeSource.notification)])
        //     : context.router.replaceAll([const BoardingRoute(), DoctorInformationDetailRoute(nakesEntity: nakesEntity, isFromLink: true, sourceType: HomeSource.notification)]);
        return;
      }
      final page = deepLink.queryParameters['p'] ?? '';
      // if (sl<ProfileBloc>().state.userResponse == null) {
      //   sl<ProfileBloc>().add(const DataProfileUserEvent(isNeedUpdate: true));
      // }
      switch (page) {
        // case 'sertifikat-imunisasi-rutin':
        //   _isLoggedIn
        //       ? context.router.replaceAll([
        //     HomeRoute(isFromLogin: true),
        //     VaccineEntryMenuRoute(type: VaccineType.IMMUNISASI_DASAR_LENGKAP, isAccountHolderKyc: sl<ProfileBloc>().state.userResponse?.data.is_kyc ?? false, isToRecommendation: false),
        //   ])
        //       : context.router.replaceAll([
        //     const BoardingRoute(),
        //   ]);
        //   break;
        // case 'rekomendasi-imunisasi-rutin':
        //   _isLoggedIn
        //       ? context.router.replaceAll([
        //     HomeRoute(isFromLogin: true),
        //     VaccineEntryMenuRoute(type: VaccineType.IMMUNISASI_DASAR_LENGKAP, isAccountHolderKyc: sl<ProfileBloc>().state.userResponse?.data.is_kyc ?? false, isToRecommendation: true),
        //   ])
        //       : context.router.replaceAll([
        //     const BoardingRoute(),
        //   ]);
        //   break;
        // case 'satusehat-skrining-sdq-srq':
        //   if (_isLoggedIn) {
        //     context.router.replaceAll([DeviceCheckPinRoute()]);
        //   } else {
        //     context.router.replaceAll([const BoardingRoute()]);
        //   }
        //   break;
        // case 'satusehat-pemulihan-akun':
        //   if (!_isLoggedIn) {
        //     context.router.replaceAll([const BoardingRoute()]);
        //   }
        //   break;
        // case 'satusehat-imt':
        //   if (_isLoggedIn) {
        //     context.router.replaceAll([DeviceCheckPinRoute()]);
        //   } else {
        //     context.router.replaceAll([const BoardingRoute()]);
        //   }
        //   break;
        // case 'satusehat-tekanan-darah':
        //   if (_isLoggedIn) {
        //     context.router.replaceAll([DeviceCheckPinRoute()]);
        //   } else {
        //     context.router.replaceAll([
        //       const BoardingRoute(),
        //     ]);
        //   }
        //   break;
        // case 'satusehat-update-versi':
        //   if (_isLoggedIn) {
        //     context.router.replaceAll([DeviceCheckPinRoute()]);
        //   } else {
        //     context.router.replaceAll([
        //       const BoardingRoute(),
        //     ]);
        //   }
        //   break;
        // case 'satusehat-gula-darah':
        //   if (_isLoggedIn) {
        //     context.router.replaceAll([DeviceCheckPinRoute()]);
        //   } else {
        //     context.router.replaceAll([
        //       const BoardingRoute(),
        //     ]);
        //   }
        //   break;
        // case 'satusehat-daftar-faskes-kyc':
        //   if (_isLoggedIn) {
        //     context.router.replaceAll([DeviceCheckPinRoute()]);
        //   } else {
        //     context.router.replaceAll([
        //       const BoardingRoute(),
        //     ]);
        //   }
        //   break;
        case 'satusehat-asam-urat':
          if (_isLoggedIn) {
            context.router.replaceAll([HomeRoute()]);
          } else {
            context.router.replaceAll([
              const OnboardingRoute(),
            ]);
          }
          break;
        case 'satusehat-kolesterol-total':
          if (_isLoggedIn) {
            context.router.replaceAll([HomeRoute()]);
          } else {
            context.router.replaceAll([
              const OnboardingRoute(),
            ]);
          }
          break;
        case 'satusehat-deteksi-risiko-kanker-paru':
          if (_isLoggedIn) {
            context.router.replaceAll([HomeRoute()]);
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

  Future<String> createLink(String doctorID) async {
    try {
      final String url = "https://satusehat.kemkes.go.id/mobile?doctorID=$doctorID";
      String packageSuffix = "";
      switch (FlavorConfig.instance.flavor) {
        case FlavorType.dev:
          packageSuffix = ".dev";
          break;
        case FlavorType.stag:
          packageSuffix = ".stag";
          break;
        default:
      }
      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: "https://fansedu.page.link",
        androidParameters: AndroidParameters(
          packageName: "com.telkom.tracencare$packageSuffix",
          fallbackUrl: Uri.parse("https://play.google.com/store/apps/details?id=com.telkom.tracencare"),
        ),
        iosParameters: IOSParameters(
          bundleId: "com.telkom.tracencare$packageSuffix",
          appStoreId: "1504600374",
          fallbackUrl: Uri.parse("https://apps.apple.com/id/app/satusehat-mobile/id1504600374?l=id"),
        ),
      );

      final dynamicLink = await _dynamicLinkInstance.buildShortLink(
        dynamicLinkParams,
      );

      return dynamicLink.shortUrl.toString();
    } catch (e) {
      return '';
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
