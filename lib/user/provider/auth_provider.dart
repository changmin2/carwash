import 'dart:async';

import 'package:carwash/car/view/carwash_record_screen.dart';
import 'package:carwash/car/view/record_detail_screen.dart';
import 'package:carwash/car/view/register_first_screen.dart';
import 'package:carwash/car/view/register_second_screen.dart';
import 'package:carwash/car/view/register_thrid_screen.dart';
import 'package:carwash/common/view/root_tap.dart';
import 'package:carwash/community/view/community_detail.dart';
import 'package:carwash/community/view/community_screen.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:carwash/user/view/profile_screen.dart';
import 'package:carwash/weather/provider/weather_provider.dart';
import 'package:carwash/weather/repository/weather_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../model/user_model.dart';
import '../view/login_screen.dart';
import '../view/splash_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProviderNotifier>((ref) {
  return AuthProviderNotifier(ref: ref);
});

class AuthProviderNotifier extends ChangeNotifier{
  final Ref ref;

  AuthProviderNotifier({
    required this.ref
  }){
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if(previous!=next){
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_,__) => RootTab(),
      routes: [
        GoRoute(
          path: 'profile',
          name: UserProfileScreen.routeName,
          builder: (_,__) => UserProfileScreen(),
        ),
        GoRoute(
          path: 'community',
          name: CommunityScreen.routeName,
          builder: (_,__) => CommunityScreen(),
          routes: [
            GoRoute(
                path: ':id',
                name: CommunityDetailScreen.routeName,
                builder: (_,__) => CommunityDetailScreen()
            ),
          ]
        ),
        GoRoute(
            path: 'recordScreen',
            name: CarWashRecordScreen.routeName,
            builder: (_,__) => CarWashRecordScreen(),
            routes: [
              GoRoute(
                path: 'recordDetail/:id',
                name: RecordDetail.routeName,
                builder: (_,state) => RecordDetail(
                    id: int.parse(state.pathParameters['id']!)
                  //rid: 123
                ),
              )
            ]
        ),
        GoRoute(
            path: 'record/register',
            name: RecordFirstScreen.routeName,
            builder: (_,state) => RecordFirstScreen(),
            routes: [
              GoRoute(
                path: 'record/register/two',
                name: RecordSecondScreen.routeName,
                builder: (_,state) => RecordSecondScreen(
                  query: state.queryParameters['query'],
                ),
                routes: [
                  GoRoute(
                    path: 'record/register/thrid',
                    name: RecordThridScreen.routeName,
                    builder: (_,state) => RecordThridScreen(
                      query: state.queryParameters['query']
                    )
                  )
                ]
              )
            ]
        )
      ]
    ),
    GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (_,__) => SplashScreen()
    ),
    GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (_,__) => LoginScreen(),
    )
  ];

  void logout(){
    ref.read(userMeProvider.notifier).logout();
  }

  //SplashScreen
  //앱을 처음 시작했을때
  //토큰이 존재하는지 확인하고
  //로그인 스크린으로 보내줄지
  //홈스크린으로 보내줄지 확인하는 과정이 필요
  FutureOr<String?> redirectLogic(BuildContext context,GoRouterState state)  {
    // final weather =  ref.read(WeatherProvider);
    // if(weather.length == 0){
    //   ref.read(WeatherProvider.notifier).getWeather();
    // }
    final UserModelBase? user = ref.read(userMeProvider);
    //로그인 중
    final logginIn = state.location == '/login';
    //회원가입 페이지 이동중인지
    final joinIn = state.location == '/login/join';
    //유저 정보가 없는데
    //로그인중이면 그대로 로그인 페이지에 두고
    //만약 로그인중이 아니라면 로그인 페이지로 이동
    if(user == null && !joinIn){

      return logginIn ? null : '/login';
    }


    //user가 null이 아님

    //UserModel
    //사용자 정보가 있는상태면
    //로그인 중이거나 현재 위치가 SplashScreen이면
    //홈으로 이동
    if(user is UserModel){
      return logginIn || state.location == '/splash' ? '/' : null;
    }

    //UserModelError
    if(user is UserModelError){
      if(joinIn){
        return '/login/join';
      }
      return logginIn ? null : '/login';
    }

    return null;
  }
}