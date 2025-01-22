import 'package:dio/dio.dart';
import 'package:fansedu/core/config/bloc/config_bloc.dart';
import 'package:fansedu/core/flavor/flavor_config.dart';
import 'package:fansedu/core/helpers/firebase/analytic_helper.dart';
import 'package:fansedu/core/helpers/firebase/firebase_messsaging_helper.dart';
import 'package:fansedu/core/helpers/firebase/notification_helper.dart';
import 'package:fansedu/core/helpers/firebase/remote_config.dart';
import 'package:fansedu/core/resources/data_interceptor.dart';
import 'package:fansedu/core/resources/rest_client.dart';
import 'package:fansedu/data/datasource/fansedu_datasource.dart';
import 'package:fansedu/data/datasource/fansedu_datasource_impl.dart';
import 'package:fansedu/data/repositories/fansedu_repository_impl.dart';
import 'package:fansedu/domain/repository/fansedu_repository.dart';
import 'package:fansedu/domain/usecase/do_login.dart';
import 'package:fansedu/domain/usecase/do_logout.dart';
import 'package:fansedu/domain/usecase/do_register.dart';
import 'package:fansedu/domain/usecase/do_reset_password.dart';
import 'package:fansedu/domain/usecase/get_profile.dart';
import 'package:fansedu/features/auth/bloc/auth_bloc.dart';
import 'package:fansedu/features/profile/bloc/profile_bloc.dart';
import 'package:fansedu/generated/l10n.dart';
import 'package:alice/alice.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:alice_dio/alice_dio_adapter.dart';

final sl = GetIt.instance;
const platform = MethodChannel("channel");

Future<void> init() async {
  Dio createDio() {
    var dio = Dio(
      BaseOptions(
        headers: {"content-type": "application/json"},
      ),
    );
    return dio;
  }

  final Dio dio = createDio();
  final FlutterLocalNotificationsPlugin notificationsPlugins = FlutterLocalNotificationsPlugin();
  if (FlavorConfig.instance.flavor != FlavorType.prod) {
    Alice alice = Alice();
    AliceDioAdapter aliceDioAdapter = AliceDioAdapter();
    alice.addAdapter(aliceDioAdapter);
    dio.interceptors.add(aliceDioAdapter);
    sl.registerSingleton<Alice>(alice);
  }
  dio.interceptors.add(DataInterceptor());
  sl.registerLazySingleton(() => NotificationHelper(notificationsPlugins));
  sl.registerLazySingleton(() => FirebaseMessagingHelpers());
  sl.registerSingleton<RestClient>(
      RestClient(dio, baseUrl: FlavorConfig.instance.server));
  sl.registerLazySingleton(() => const AppLocalizationDelegate());
  sl.registerLazySingleton(() => ConfigBloc());
  sl.registerLazySingleton(() => AnalyticsHelpers());
  sl.registerLazySingleton(() => RemoteConfigHelper());

  // datasource
  sl.registerLazySingleton<FanseduDatasource>(() => FanseduDatasourceImpl(sl()));

  // repository
  sl.registerLazySingleton<FanseduRepository>(() => FanseduRepositoryImpl(sl()));

  // usecase
  sl.registerLazySingleton(() => DoLogin(sl()));
  sl.registerLazySingleton(() => DoRegister(sl()));
  sl.registerLazySingleton(() => DoResetPassword(sl()));
  sl.registerLazySingleton(() => DoLogout(sl()));
  sl.registerLazySingleton(() => GetProfile(sl()));

  // bloc
  sl.registerLazySingleton(() => AuthBloc(doLogin: sl()));
  sl.registerLazySingleton(() => ProfileBloc(getProfile: sl()));
}