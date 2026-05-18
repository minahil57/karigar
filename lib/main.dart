import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:karigar/export.dart';
import 'package:karigar/firebase_options.dart';
import 'package:karigar/services/notifications/firebase_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  DioHelper.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  HttpOverrides.global = AppHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseNotificationService notificationService =
      FirebaseNotificationService();
  notificationService.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  });
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = kcBlackColor
    ..textColor = kcWhitecolor
    ..indicatorColor = kcWhitecolor
    ..userInteractions = false
    ..radius = 14
    ..indicatorSize = 30
    ..dismissOnTap = false
    ..maskColor = Colors.transparent;

  Get.put(AppNotifier());

  runApp(const KarigarApp());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  log('Handling a background message ${message.messageId}');
}
