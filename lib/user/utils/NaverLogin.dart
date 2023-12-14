import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLogin {
  static login() async {
    try {
      FlutterNaverLogin.logIn().then((res) {
        if (res.status == NaverLoginStatus.loggedIn) {
          debugPrint('로그인 성공(NaverAccessToken)= ');
          NaverAccountResult account = res.account;
          debugPrint('로그인 성공(account.id)= ' + account.id);
          debugPrint('로그인 성공= ' + account.toString());
        } else {
          debugPrint('로그인 실패=' + res.errorMessage);
        }
      });
    } catch (e) {
      debugPrint('login Error=' + e.toString());
    }
  }

  static logout() async {
    try {
      NaverLoginResult res = await FlutterNaverLogin.logOut();
      debugPrint('로그인 아웃= ' + res.status.toString());
      debugPrint('로그11111 아웃= ' + res.toString());
    } catch (e) {
      debugPrint('logout Error=' + e.toString());
    }

    // if (res.status != NaverLoginStatus.loggedIn) {
    //   debugPrint('로그인 아웃= ' + res.status.toString());
    // }
  }

  static Future<void> getUserPressed() async {
    /* 로그인 채크함수가 안됨
    FlutterNaverLogin.isLoggedIn.then((value) {
      debugPrint('3333333333 value= ' + value.toString());
    });
    */
    // 로그인 안하고 읽으면 에러 발생함 ()
    FlutterNaverLogin.currentAccount().then((value) {
      if (value.name != null) debugPrint('name= ' + value.name);
    }).catchError((e) {
      debugPrint('getUserPressed 에러 = ' + e.toString());
    });
  }
}
