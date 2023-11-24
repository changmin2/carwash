import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/view/main_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                    const Row(
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
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: '아이디를 입력하세요.',
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

                    TextFormField(
                      // 비밀번호 효과
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: '비밀번호를 입력하세요.',
                        suffixIcon: Icon(Icons.visibility_outlined),
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

                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: '닉네임을 입력하세요.',
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

                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: '나의 소개를 입력하세요.',
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// 회원 가입 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                          );
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
}
