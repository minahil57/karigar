
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:karigar/export.dart';
import 'package:overlay_support/overlay_support.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

class FirebaseNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

Future<void> init() async {

  // 1️⃣ Request permission
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  log("User permission: ${settings.authorizationStatus}");

  // 2️⃣ 👉 ADD IT HERE (IMPORTANT FOR iOS)
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // 3️⃣ Initialize local notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const InitializationSettings initializationSettings = InitializationSettings(
  android: AndroidInitializationSettings('notification_icon'),
    iOS: DarwinInitializationSettings(),
  );                           

 await flutterLocalNotificationsPlugin.initialize(
  settings: initializationSettings,
);

  // 4️⃣ Create Android channel
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // 5️⃣ Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (message.notification != null) {

      // Overlay UI
      showOverlayNotification(
        (context) {
          return CustomNotificationCard(
            title: message.notification?.title ?? "No Title",
            body: message.notification?.body ?? "No Body",
            time: DateTime.now(),
          );
        },
        duration: const Duration(seconds: 4),
      );

      // System notification (important for iOS too)
      await flutterLocalNotificationsPlugin.show(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: message.notification?.title,
        body: message.notification?.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
      );
    }
  });

  // 6️⃣ When notification is tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log("Notification clicked");
  });
}

Future<String?> getFcmToken() async {
    try {
      final token = await _messaging.getToken();
      log("FCM Token: $token");
      return token;
    } catch (e) {
      log("FCM Token Error: $e");
      return null;
    }
  }
}
