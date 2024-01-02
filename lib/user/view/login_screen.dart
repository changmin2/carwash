import 'dart:io';

import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/user/utils/NaverLogin.dart';

import 'package:carwash/user/view/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../common/const/colors.dart';
import '../provider/user_me_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  final _idFormKey = GlobalKey<FormState>();
  final _psFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(userMeProvider);

    return DefaultLayoutV2(
      child: SingleChildScrollView(
        // 키보드가 올라오고 화면을 드래그하면 키보드가 사라짐.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ----------------------------------------------------------------
              /// 이미지
              /// ----------------------------------------------------------------
              Image.asset(
                'asset/img/login.png',
                width: double.infinity,
                height: 150,
                alignment: Alignment.topLeft,
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// ----------------------------------------------------------------
              /// 타이틀
              /// ----------------------------------------------------------------
              Text(
                'Welcome back ,',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Text(
                '세차파트너에 오신걸 환영합니다.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// ----------------------------------------------------------------
              /// 아이디
              /// ----------------------------------------------------------------
              Form(
                key: _idFormKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: '아이디를 입력해주세요.',
                    // prefixIcon: Icon(Icons.person_2_outlined),
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                  onChanged: (String value) {
                    username = value;
                  },
                  validator: (value) {
                    if (value!.length < 3) {
                      return "아이디를 3글자 이상 입력해주세요.";
                    } else if (value!.length > 15) {
                      return "아이디를 15자 이하로 입력해주세요.";
                    }
                    if (!isValidEmailFormat(value!)) {
                      return "영문과 숫자 조합으로 입력해주세요.";
                    }
                  },
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// ----------------------------------------------------------------
              /// 비밀번호
              /// ----------------------------------------------------------------
              Form(
                key: _psFormKey,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '비밀번호를 입력해주세요,',
                    // prefixIcon: Icon(Icons.https_outlined),
                    prefixIcon: Icon(Iconsax.password_check),
                    suffixIcon: Icon(Icons.visibility_outlined),
                  ),
                  onChanged: (String value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.length < 3) {
                      return "비밀번호를 3글자 이상 입력해주세요.";
                    } else if (value!.length > 15) {
                      return "비밀번호를 15자 이하로 입력해주세요.";
                    }
                    if (!isValidEmailFormat(value)) {
                      return "영문과 숫자 조합으로 입력해주세요.";
                    }
                  },
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// ----------------------------------------------------------------
              /// 로그인 버튼
              /// ----------------------------------------------------------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_idFormKey.currentState!.validate() && _psFormKey.currentState!.validate()) {
                      await ref.read(userMeProvider.notifier).login(username: username, password: password, context: context);
                    }
                  },
                  // onPressed: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const MainScreen(),
                  //     ),
                  //   );
                  // },
                  child: const Text('로그인'),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems / 2),

              /// ----------------------------------------------------------------
              /// 회원가입 텍스트버튼
              /// ----------------------------------------------------------------
              TextButton(
                onPressed: () => THelperFunctions.navigateToScreen(context, const SignUpScreen()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "세차파트너에 처음이신가요?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Text(
                      "회원가입",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: PRIMARY_COLOR,
                            decoration: TextDecoration.underline,
                            decorationThickness: 5,
                            decorationColor: PRIMARY_COLOR,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5.0,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Ink.image(
                      image: const AssetImage('asset/img/naver_logo.png'),
                      width: 50,
                      height: 50,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(35.0),
                        ),
                        onTap: () async {
                          _login_naver();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Platform.isIOS ?
                  Card(
                    elevation: 5.0,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Ink.image(
                      image: const AssetImage('asset/img/apple_logo.png'),
                      width: 50,
                      height: 50,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(35.0),
                        ),
                        onTap: () async {
                          var res = await _login_apple();
                          String id = res.user!.email!;
                          String ps = res.user!.uid!;
                          ref.read(userMeProvider.notifier).snslogin(username: ps, password: id, nickname: "temp", context: context);
                        },
                      ),
                    ),
                  )
                  : Container()    ,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmailFormat(String word) {
    return RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9])").hasMatch(word);
  }

  void _login_naver() async{
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    ref.read(userMeProvider.notifier).snslogin(username: res.account.id, password: res.account.mobile.toString()+res.account.id, context: context,nickname: res.account.nickname);
  }

  Future<UserCredential> _login_apple() async{
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}

