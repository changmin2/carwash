import 'package:carwash/common/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'common/provider/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  var initialzationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  var initialzationSettingsIOS = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid, iOS: initialzationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

}

void _permissionWithNotification() async {

  if (await Permission.notification.isDenied &&
      !await Permission.notification.isPermanentlyDenied) {
    await [Permission.notification].request();
  }
}

void main() async{
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeNotification();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    var androidNotiDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
    );
    var iOSNotiDetails =  const DarwinNotificationDetails(

    );
    var details =
    NotificationDetails(android: androidNotiDetails, iOS: iOSNotiDetails);
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        details,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(message);
  });


  //푸쉬알림설정 끝
  await initializeDateFormatting();

  KakaoSdk.init(nativeAppKey: '7d131476e9dd71890bf99ffa94dec12d'); // 이 줄을 runApp 위에 추가한다.
  runApp(
      const ProviderScope(child: _App())
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      // 시스템 설정에 따른 Theme
      // themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}






