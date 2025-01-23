import 'package:alice/alice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/common/device_info_data.dart';
import 'package:fansedu/core/config/bloc/config_bloc.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/flavor/flavor_config.dart';
import 'package:fansedu/core/helpers/firebase/firebase_messsaging_helper.dart';
import 'package:fansedu/core/helpers/firebase/notification_helper.dart';
import 'package:fansedu/core/helpers/firebase/remote_config.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:fansedu/features/about/bloc/about_bloc.dart';
import 'package:fansedu/features/auth/bloc/auth_bloc.dart';
import 'package:fansedu/features/profile/bloc/profile_bloc.dart';
import 'package:fansedu/features/profile/bloc/update_profile_bloc.dart';
import 'package:fansedu/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fansedu/core/resources/injection_container.dart' as injector;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  prefInstance = await SharedPreferences.getInstance();
  await FirebaseMessagingHelpers().initNotification();
  await initPlatformState();

  FlavorConfig(
      flavor: FlavorType.prod,
      color: Colors.teal,
      server: serverProd,
      values: const FlavorValues(
        titleApp: "Fansedu",
      ),
  );

  await injector.init();
  // await initHive();

  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  injector.sl<RemoteConfigHelper>().initFirebase();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    if (prefHelpers.getAppLang == null) {
      prefInstance.setString(PrefsKey.appLang.name, "id");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigBloc>(
      create: (ctx) => injector.sl<ConfigBloc>(),
      child: KeyboardDismisser(
        child: BlocBuilder<ConfigBloc, ConfigState>(builder: (ctx, state) {
          return _main(ctx, Locale(state.local == '' ? 'id' : state.local));
        }),
      ),
    );
  }

  Widget _main(BuildContext ctx, Locale locale) {
    var app = AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark),
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: locale,
          localizationsDelegates: const [
            S.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          routerDelegate: _appRouter.delegate(
            navigatorObservers: () => [AutoRouteObserver()],
          ),
          theme: ThemeData(fontFamily: "PlusJakartaSans"),
          routeInformationParser: _appRouter.defaultRouteParser(),
          supportedLocales: S.delegate.supportedLocales,
        ),
      ),
    );
    if (FlavorConfig.instance.flavor != FlavorType.prod) {
      var alice = injector.sl<Alice>();
      alice.setNavigatorKey(_appRouter.navigatorKey);
    }
    injector.sl<NotificationHelper>().initialize(_appRouter.navigatorKey);
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(
          create: (BuildContext context) => injector.sl<AuthBloc>()),
      BlocProvider<ProfileBloc>(create: (BuildContext context) => injector.sl<ProfileBloc>()),
      BlocProvider<AboutBloc>(create: (BuildContext context) => injector.sl<AboutBloc>()),
      BlocProvider<UpdateProfileBloc>(create: (BuildContext context) => injector.sl<UpdateProfileBloc>())
    ], child: app);
  }
}
