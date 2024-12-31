import 'package:fansedu/core/common/device_info_data.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/flavor/flavor_config.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fansedu/core/resources/injection_container.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefInstance = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  // await FirebaseMessagingHelpers().initNotification();
  await initPlatformState();

  FlavorConfig(
    flavor: FlavorType.dev,
    color: Colors.teal,
    server: serverDev,
    values: const FlavorValues(
      titleApp: "Fansedu - Dev",
    ),
  );

  await injector.init();
  // await initHive();

  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // injector.sl<RemoteConfigHelper>().initFirebase();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}