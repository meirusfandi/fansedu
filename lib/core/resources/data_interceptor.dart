import 'package:dio/dio.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';

class DataInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? lang = prefHelpers.getAppLang;
    options.headers["accept-language"] = lang;
    super.onRequest(options, handler);
  }
}