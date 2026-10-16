import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _fcm = FirebaseMessaging.instance;
  static final _local = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    await _fcm.requestPermission();
    print('FCM token: ${await _fcm.getToken()}');

    await _local.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );

    FirebaseMessaging.onMessage.listen((m) {
      final n = m.notification;
      if (n != null) show(n.title ?? '', n.body ?? '');
    });
  }

  static Future<void> show(String title, String body) {
    return _local.show(
      id: 0,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'reg_channel',
          'Registration',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
}