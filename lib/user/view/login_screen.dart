import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/view/main_screen.dart';
import 'package:carwash/user/view/signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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
    final state = ref.watch(userMeProvider);

    return DefaultLayoutV2(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'asset/img/login.png',
                width: double.infinity,
                height: 150,
                alignment: Alignment.topLeft,
              ),
              Text(
                'Welcome back ,',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Text(
                '세차파트너에 오신걸 환영합니다.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2),
              Form(
                key: _idFormKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: '아이디를 입력해주세요.',
                    prefixIcon: Icon(Icons.person_2_outlined),
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
              Form(
                key: _psFormKey,
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '비밀번호를 입력해주세요,',
                    prefixIcon: Icon(Icons.https_outlined),
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
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  // onPressed: () async {
                  //   if (_idFormKey.currentState!.validate() &&
                  //       _psFormKey.currentState!.validate()) {
                  //     await ref.read(userMeProvider.notifier).login(
                  //         username: username,
                  //         password: password,
                  //         context: context);
                  //   }
                  // },
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  },
                  child: const Text('로그인'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("세차파트너에 처음이신가요?",style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Text("회원가입",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: PRIMARY_COLOR)),
                  ],
                ),
              ),
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const SignUpScreen()));
              //     },
              //     style: ElevatedButton.styleFrom().copyWith(
              //       backgroundColor:
              //           const MaterialStatePropertyAll(Colors.white),
              //     ),
              //     child: const Text("회원가입",
              //         style: TextStyle(
              //           color: Colors.black,
              //         )),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmailFormat(String word) {
    return RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9])").hasMatch(word);
  }
}
