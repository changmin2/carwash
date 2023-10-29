import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/user/view/signup_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';
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
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 800,
                height: 350,
                child: Image.asset(
                  'asset/img/login.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Form(
                key: _idFormKey,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'ID'),
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
              SizedBox(height: 10),
              Form(
                key: _psFormKey,
                child: TextFormField(
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_idFormKey.currentState!.validate() &&
                          _psFormKey.currentState!.validate()) {
                        await ref.read(userMeProvider.notifier).login(
                            username: username,
                            password: password,
                            context: context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text('login')),
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff132B35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("회원가입"),
                ),
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
}
