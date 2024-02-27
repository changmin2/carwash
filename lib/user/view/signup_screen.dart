import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/user/view/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/utils/helpers/helper_functions.dart';
import '../model/join_request.dart';
import '../repository/user_me_repository.dart';

enum Select {AGREE,DISAGREE}

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends ConsumerState<SignUpScreen> {
  Select? _select;
  String username = '';
  String password = '';
  String nickname = '';
  String intro = '';
  bool idDuplicateCheck = true;
  bool nickNameDuplicateCheck = true;



  final _idFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _nicknameFormKey = GlobalKey<FormState>();
  final _introFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


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
                          idDuplicateCheck = true;
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
                          if(!idDuplicateCheck){
                            return "중복된 아이디 입니다!";
                          }
                        },
                      ),
                    ),


                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// 비밀번호
                    const Row(
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
                    const Row(
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
                          nickNameDuplicateCheck = true;
                          nickname = value;
                        },
                        validator: (value) {
                          if (value!.length < 2) {
                            return "닉네임을 2글자 이상 입력해주세요.";
                          }
                          if(!nickNameDuplicateCheck){
                            return "중복된 닉네임 입니다!";
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// 나의 소개
                    const Row(
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

                    Row(
                        children: [
                          Container(
                            height: 40,
                            child: TextButton(
                              onPressed: () async {

                                 var url = Uri.parse("https://changmin2.com/%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A8/");
                                if (await canLaunchUrl(url)) {
                                launchUrl(url);
                                }
                              },
                              child: Center(
                                child: Text(
                                  "개인정보 처리방침",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: PRIMARY_COLOR,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 5,
                                    decorationColor: PRIMARY_COLOR,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('동의'),
                              leading: Radio<Select>(
                                value: Select.AGREE,
                                groupValue: _select,
                                onChanged: (Select? value) {
                                  setState(() {
                                    _select = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: const Text('비동의'),
                              leading: Radio<Select>(
                                value: Select.DISAGREE,
                                groupValue: _select,
                                onChanged: (Select? value) {
                                  setState(() {
                                    _select = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ]
                    ),

                    /// 회원 가입 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_idFormKey.currentState!.validate() &&
                              _passwordFormKey.currentState!.validate() && _nicknameFormKey!.currentState!.validate()
                              && _introFormKey.currentState!.validate()) {
                          if(_select == null){
                            await ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('개인정보 처리방침 동의를 해주세요!'),
                                  duration: Duration(seconds: 1),
                                )
                            );
                            return;
                          }else if(_select == Select.DISAGREE){
                            await ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('개인정보 처리방침을 동의해주세요!'),
                                  duration: Duration(seconds: 1),
                                )
                            );
                            return;
                          }
                          JoinRequest request = new JoinRequest(memberId: username, password: password,
                                nickname: nickname, intro: intro);
                            String result = await ref.read(userMeRepositoryProvider).join(request);
                            if(result=='-1'){
                              idDuplicateCheck = false;
                              _idFormKey.currentState!.validate();
                              await ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('중복된 아이디입니다!'),
                                    duration: Duration(seconds: 1),
                                  )
                              );
                            }else if(result == '-2'){
                              nickNameDuplicateCheck = false;
                              _nicknameFormKey.currentState!.validate();
                              await ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('중복된 닉네임입니다!'),
                                    duration: Duration(seconds: 1),
                                  )
                              );
                            }else{
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



