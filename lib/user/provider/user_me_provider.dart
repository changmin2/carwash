import 'package:carwash/user/provider/loginCheck_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/const/data.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../../weather/provider/weather_provider.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../repository/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier,UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProivder);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  final weather =  ref.read(WeatherProvider);


  return UserMeStateNotifier(
      authRepository: authRepository,
      userMeRepository: userMeRepository,
      storage: storage,
      weather: weather
  );
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?>{
  final AuthRepository authRepository;
  final UserMeRepository userMeRepository;
  final FlutterSecureStorage storage;
  final weather;
  UserMeStateNotifier({
    required this.authRepository,
    required this.userMeRepository,
    required this.storage,
    required this.weather
  }) : super(UserModelLoading()){
    //내정보 가져오기
    getMe();
  }


  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    //spalsh화면을 2초 보여주기 위한 스탑워치
    Stopwatch stopwatch = new Stopwatch();
    stopwatch.start();

    if(refreshToken == null || accessToken == null){
      await Future.delayed(Duration(milliseconds: (1800)));
      state = null;
      return;
    }


    final resp = await userMeRepository.getMe();
    Duration get = stopwatch.elapsed;
    stopwatch.stop();
    if(get.inMilliseconds<2000){
      await Future.delayed(Duration(milliseconds: (2000-get.inMilliseconds)));
    }
    state = resp;

  }

  Future<void> reloadMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await userMeRepository.getMe();
    state = resp;

  }

  Future<UserModelBase> login({
    required String username,
    required String password,
    required BuildContext context,
  }) async{
    try{
      state = UserModelLoading();
      final resp = await authRepository.login(username: username, password: password);

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);

      final userResponse = await userMeRepository.getMe();

      state = userResponse;

      return userResponse;
    }catch(e) {
      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<UserModelBase> snslogin({
    required String username,
    required String password,
    required String nickname,
    required BuildContext context,
  }) async{
    try{
      state = UserModelLoading();

      final resp = await authRepository.snslogin(username: username, password: password, nickname: nickname);

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);

      final userResponse = await userMeRepository.getMe();

      state = userResponse;

      return userResponse;
    }catch(e) {
      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;
    //동시에 실행
    Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);
    await FlutterNaverLogin.logOut();
    await FirebaseAuth.instance.signOut();
    //await storage.delete(key: REFRESH_TOKEN_KEY);
    //await storage.delete(key: ACCESS_TOKEN_KEY);
  }

  Future<void> withDrawl() async{
    await authRepository.withDrawl();
    state = null;

    Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY)
    ]);
  }

}