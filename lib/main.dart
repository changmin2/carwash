import 'dart:async';
import 'dart:convert';

import 'package:carwash/common/theme/theme.dart';
import 'package:carwash/community/view/community_screen_bak.dart';
import 'package:carwash/firebase/provider/pushRoute_provider.dart';
import 'package:carwash/user/view/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'common/provider/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

//! Notification을 위한 StreamController 전역 변수 선언
String pushRoute = '';
final streamController = StreamController<String>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}


void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
      'high_importance_channel', 'high_importance_notification',
      importance: Importance.max));

  DarwinInitializationSettings iosInitializationSettings =
          const DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestSoundPermission: true
          );
  // IOSInitializationSettings iosInitializationSettings =
  // IOSInitializationSettings(
  //   requestAlertPermission: true,
  //   requestBadgePermission: true,
  //   requestSoundPermission: true
  // );

  await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: iosInitializationSettings
      ),

      //앱이 켜져있을때 푸쉬 알림 클릭시 해당 경로로 이동 설정
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        print('onDidReceiveNotificationResponse - payload: ${details.payload}');

        final payload = details.payload ?? '';

        final parsedJson = jsonDecode(jsonEncode(payload));

        if(payload!=''){
          pushRoute = payload;
          streamController.add(payload);
        }
      }
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

}





void main() async{
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();
  KakaoSdk.init(nativeAppKey: '7d131476e9dd71890bf99ffa94dec12d'); // 이 줄을 runApp 위에 추가한다.

  //푸쉬알림설정
  initializeNotification();

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





