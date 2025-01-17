import 'dart:convert';
import 'package:alice/alice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/config/helpers/lang_config.dart';
import 'package:fansedu/core/config/model/payload_notif.dart';
import 'package:fansedu/core/helpers/prefs/pref_helpers.dart';
import 'package:fansedu/core/helpers/prefs/prefs_key_helpers.dart';
import 'package:fansedu/core/helpers/secure_storage/storage_helpers.dart';
import 'package:fansedu/core/resources/injection_container.dart';
import 'package:fansedu/core/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationHelper(this._notificationsPlugin);

  Future<void> initialize(GlobalKey<NavigatorState> navigatorKey) async {
    _configureLocalTimeZone();
    var androidInitialize =
    const AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInitialize = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    var initializationSettings =
    InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    final details =
    await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      notificationResponse = details.notificationResponse;
    }
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final token = await storage.getAuthToken ?? '';
        final language = LangConfig.instance.langValue;
        final context = navigatorKey.currentState?.context;
        if (context != null) {
          onTapNotification(
              notificationResponse: notificationResponse,
              context: context,
              token: token,
              language: language);
        }
      },
    );
  }

  Future<void> cancelAllNotif() async {
    try {
      await _notificationsPlugin.cancelAll();
      // prefInstance.remove(PrefsKey.lastDateCheckNotif.name);
    } catch (_) {}
  }

  Future<void> cancelNotif(int id) async {
    try {
      await _notificationsPlugin.cancel(id);
    } catch (_) {}
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    // final String timeZone = await FlutterTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future showNotif(
      {required int id,
        required String title,
        required String body,
        String? payload}) async {
    _notificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          title,
          importance: Importance.max,
          priority: Priority.high,
          largeIcon: const DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  /// Scheduled Notification
  Future<void> scheduledNotification({
    required int hour,
    required int minutes,
    required int id,
    required String title,
    required String body,
    required String channelId,
  }) async {
    final PayloadNotif payloadMap =
    PayloadNotif(scheduleId: channelId, hour: hour, minutes: minutes);
    final payload = jsonEncode(payloadMap);
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        title,
        importance: Importance.max,
        priority: Priority.max,
        largeIcon: const DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _convertTime(hour, minutes),
      details,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
    _notificationsPlugin.show(id, title, body, details).then((_) {});
  }

  Future<void> onTapNotification(
      {required NotificationResponse? notificationResponse,
        required BuildContext context,
        required String token,
        required String language,
        bool? isFromLaunch}) async {
    if (notificationResponse?.id == 0) {
      sl<Alice>().showInspector();
    } else {
      token.replaceAll('Bearer ', '');
      context.router.replaceAll([HomeRoute()]);
    }
  }
}

NotificationResponse? notificationResponse;
