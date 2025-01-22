import 'dart:developer';
import 'dart:math' as math;

import 'package:fansedu/core/helpers/firebase/notification_helper.dart';
import 'package:fansedu/core/resources/injection_container.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelpers {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    firebaseMessaging.getAPNSToken().then((apns) {
      log('firebase permission: $apns');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      sl<NotificationHelper>().showNotif(
        id: math.Random().nextInt(1000),
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
      );
      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification?.title}');
        log('Message also contained a notification: ${message.notification?.body}');
      }
    });
  }

  Future<String> getFcmToken() async {
    try {
      String? fcmToken = await firebaseMessaging.getToken();
      return fcmToken ?? '';
    } catch (e) {
      return '';
    }
  }
}
