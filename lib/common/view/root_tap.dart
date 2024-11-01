import 'dart:io';

import 'package:carwash/car/view/carwash_record_screen.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/provider/go_router.dart';
import 'package:carwash/common/view/main/main_screen.dart';
import 'package:carwash/community/view/community_screen.dart';
import 'package:carwash/firebase/provider/pushRoute_provider.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:carwash/user/view/profile/profile_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../community/view/community_detail_screen.dart';
import '../../main.dart';
import '../const/colors.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectIndex = 0;
  int _nowscreen = 0;
  var messageString = "";


  @override
  void initState() {

    super.initState();
    _requestPermission();
    _tabController = TabController(
      length: 4,
      vsync: this,

      /// 탭 변경 애니메이션 시간
      animationDuration: const Duration(milliseconds: 0),
    );
    _tabController.addListener(tabListener);
    _tabController.animateTo(_selectIndex);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      String? route = message.data['routeId'];

      if(Platform.isIOS){

      }else{
        if (notification != null) {
          FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'high_importance_notification',
                importance: Importance.max,
              ),
            ),
            payload: route
          );

          setState(() {
            messageString = message.notification!.body!;
            print("Foreground 메시지 수신: $messageString");

          });
        }
      }

    });
    print('end');
    super.initState();
  }


  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    //controller.dispose();

    super.dispose();
  }

  void tabListener() {
    setState(() {
      _selectIndex = _tabController.index;
    });
  }

  void changeTab(int index,int? nowscreen){
    _nowscreen = nowscreen!;
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {

    Stream  route = streamController.stream;

    return StreamBuilder(
      stream: route,
      builder: (BuildContext context,AsyncSnapshot snapshot){

        if(snapshot.data != null && snapshot.data!=''){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            streamController.add('');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CommunityDetailScreen(id: int.parse(snapshot.data.split("/")[1])
                    )
                )
            );
          });
        }

        return DefaultLayoutV2(
        bottomNavagtionBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: PRIMARY_COLOR,
            unselectedItemColor: Colors.black,
            elevation: 0,
            backgroundColor: Colors.white,
            onTap: (int index) {
              _tabController.animateTo(index);
            },
            currentIndex: _selectIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Iconsax.home), label: '홈'),
              BottomNavigationBarItem(icon: Icon(Iconsax.message_edit), label: '세차기록'),
              BottomNavigationBarItem(icon: Icon(Iconsax.messages_3), label: '커뮤니티'),
              BottomNavigationBarItem(icon: Icon(Iconsax.user), label: '내정보'),
            ],
          ),
        ),
        child: DefaultTabController(
          length: 4,
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children:  [
              MainScreen(tabController: changeTab),
              CarWashRecordScreen(),
              CommunityScreen(nowscreen: _nowscreen),
              UserProfileScreen(),
            ],
          ),
        ),
      );}
    );
  }
}

//각종 권한 요청
Future<void> _requestPermission() async {

  if (Platform.isIOS) {
    // iOS에서 알림 권한 요청 코드

    final IOSFlutterLocalNotificationsPlugin? iosImplementation = FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

    if (iosImplementation != null) {
      bool? result = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      if (result != null && result) {
        print('Notification permission granted.');
      } else {
        print('Notification permission denied.');
      }
    }
  } else if (Platform.isAndroid) {
    await Permission.notification.request();
    // Android에서 알림 권한 요청 코드
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      // 권한이 허용되었을 때 추가 작업 수행
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // 권한이 거부되었거나 영구적으로 거부된 경우
    } else {
      await Permission.notification.request();
    }
  }
}