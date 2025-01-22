import 'package:fansedu/core/common/package_info_data.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelpers {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({required String userId}) async {
    try {
      await _analytics.setUserId(id: userId);
      await _analytics.setUserProperty(name: 'version', value: packageInfo.version);
    } catch (_) {}
  }

  Future setEventProperty({required AnalyticEventType type, Map<String, dynamic>? param}) async {
    try {
      Map<String, Object> objectMap = (param ?? await genericPropertyAnalytics()).cast<String, Object>();
      await _analytics.logEvent(
        name: type.name,
        parameters: objectMap,
      );
    } catch (_) {}
  }

  Future setEventPropertyWV({required String eventName, Map<String, dynamic>? param}) async {
    try {
      Map<String, Object> objectMap = (param ?? await genericPropertyAnalytics()).cast<String, Object>();

      await _analytics.logEvent(name: eventName, parameters: objectMap);
    } catch (_) {}
  }

  Future<Map<String, dynamic>> genericPropertyAnalytics() async {
    final userId = await storage.getUserId;
    return <String, dynamic>{'user_id': userId, 'timestamp': DateTime.now()};
  }
}
