import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/user/model/edit_request.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:carwash/user/view/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/utils/helpers/helper_functions.dart';
import '../model/join_request.dart';
import '../model/user_model.dart';
import '../repository/user_me_repository.dart';


class EditUserScreen extends ConsumerStatefulWidget {
  const EditUserScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends ConsumerState<EditUserScreen> {

  String nickname = '';
  String intro = '';
  bool nickNameDuplicateCheck = true;

  final _nicknameFormKey = GlobalKey<FormState>();
  final _introFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userMeProvider) as UserModel;
    nickname = user.nickname;
    intro = user.intro;
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '유저 정보 수정',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: PRIMARY_COLOR),
                      )
                    ],
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              Form(
                child: Column(
                  children: [

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
                        initialValue: nickname,
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
                        initialValue: intro,
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
                          if (_nicknameFormKey!.currentState!.validate() && _introFormKey.currentState!.validate()) {
                            EditRequest request = new EditRequest(nickname: nickname, intro: intro);

                            String result = await ref.read(userMeRepositoryProvider).edit(request);
                            if(result=='-2'){
                              nickNameDuplicateCheck = false;
                              _nicknameFormKey.currentState!.validate();
                              await ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('중복된 아이디입니다!'),
                                    duration: Duration(seconds: 1),
                                  )
                              );
                            }
                            else{
                              await ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('수정 완료'),
                                    duration: Duration(seconds: 1),
                                  )
                              );
                              await Future.delayed(const Duration(milliseconds: 1000), () {
                              });
                              await ref.read(userMeProvider.notifier).reloadMe();
                            }

                          }
                        },
                        child: const Text("수정"),
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
}



