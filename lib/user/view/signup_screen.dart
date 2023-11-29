import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/join_request.dart';
import '../repository/user_me_repository.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    String username = '';
    String password = '';
    String nickname = '';
    String intro = '';

    final _idFormKey = GlobalKey<FormState>();
    final _passwordFormKey = GlobalKey<FormState>();
    final _nicknameFormKey = GlobalKey<FormState>();
    final _introFormKey = GlobalKey<FormState>();

    return DefaultLayoutV2(
      appBar: AppBar(
        elevation: 0.0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      child: SingleChildScrollView(
        // 키보드가 올라오고 화면을 드래그하면 키보드가 사라짐.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // SizedBox(
              //   width: double.infinity,
              //   height: 150,
              //   child: Lottie.network(
              //       'https://lottie.host/44d31ad4-a3ad-411c-aa32-af1b7017ba59/cIas9Lfw89.json'),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '세차파트너',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: PRIMARY_COLOR),
                      ),
                      Text(
                        ' 가 되어',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.xs),
                  Text(
                    '여러 회원분들과',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: TSizes.xs),
                  Text(
                    '세차에 대해 공유해보세요!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              Form(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('아이디'),
                        Text(
                          ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.sm),

                    /// 아이디
                    Form(
                      key: _idFormKey,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '아이디를 입력하세요.',
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

                    /// 비밀번호
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('비밀번호'),
                        Text(
                          ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),

                    const SizedBox(height: TSizes.sm),

                    Form(
                      key: _passwordFormKey,
                      child: TextFormField(
                        // 비밀번호 효과
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: '비밀번호를 입력하세요.',
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
                          if (!isValidEmailFormat(value!)) {
                            return "영문과 숫자 조합으로 입력해주세요.";
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// 닉네임
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('닉네임'),
                      ],
                    ),

                    const SizedBox(height: TSizes.sm),

                    Form(
                      key: _nicknameFormKey,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '닉네임을 입력하세요.',
                        ),
                        onChanged: (String value) {
                          nickname = value;
                        },
                        validator: (value) {
                          if (value!.length < 2) {
                            return "닉네임을 2글자 이상 입력해주세요.";
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// 나의 소개
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('나의 소개'),
                      ],
                    ),

                    const SizedBox(height: TSizes.sm),

                    Form(
                      key: _introFormKey,
                      child: TextFormField(
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: '나의 소개를 입력하세요.',
                        ),
                        onChanged: (String value) {
                          intro = value;
                        },
                        validator: (value) {
                          if (value!.length < 3) {
                            return "나의 소개를 3글자 이상 입력해주세요.";
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// 회원 가입 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_idFormKey.currentState!.validate() &&
                              _passwordFormKey.currentState!.validate() && _nicknameFormKey!.currentState!.validate()
                              && _introFormKey.currentState!.validate()) {
                            JoinRequest request = new JoinRequest(memberId: username, password: password,
                                nickname: nickname, intro: intro);
                            await ref.read(userMeRepositoryProvider).join(request);
                            await ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('회원가입 완료'),
                                  duration: Duration(seconds: 1),
                                )
                            );
                            await Future.delayed(const Duration(milliseconds: 1000), () {
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("회원 가입"),
                      ),
                    ),
                  ],
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
