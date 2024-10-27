// import 'dart:convert';
//
// import 'package:carwash/user/view/splash_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:go_router/go_router.dart';
//
// class FirebaseMessageSettings{
//
//   static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     print("백그라운드 메시지 처리.. ${message.notification!.body!}");
//   }
//
//
//   static void initializeNotification(BuildContext context) async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(const AndroidNotificationChannel(
//         'high_importance_channel', 'high_importance_notification',
//         importance: Importance.max));
//
//     DarwinInitializationSettings iosInitializationSettings =
//     const DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true
//     );
//     // IOSInitializationSettings iosInitializationSettings =
//     // IOSInitializationSettings(
//     //   requestAlertPermission: true,
//     //   requestBadgePermission: true,
//     //   requestSoundPermission: true
//     // );
//
//     await flutterLocalNotificationsPlugin.initialize(
//         InitializationSettings(
//             android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//             iOS: iosInitializationSettings
//         ),
//
//         //앱이 켜져있을때 푸쉬 알림 클릭시 해당 경로로 이동 설정
//         onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse,
//     );
//
//
//
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//   }
//
//
// }