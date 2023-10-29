import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      child: SingleChildScrollView(
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '세차 파트너',
                        style: TextStyle(
                          color: Color(0xff2A9D8F),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      Text(
                        '가 되어',
                        style: TextStyle(
                          fontSize: TSizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields / 4),
                  Text(
                    '여러 회원분들과',
                    style: TextStyle(
                      fontSize: TSizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields / 4),
                  Text(
                    '세차에 대해 공유해보세요!!!',
                    style: TextStyle(
                      fontSize: TSizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              Form(
                child: Column(
                  children: [
                    /// 아이디
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                        labelText: "아이디",
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// 비밀번호
                    TextFormField(
                      // 비밀번호 효과
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "비밀번호",
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    /// 닉네임
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "닉네임",
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "나의 소개",
                        prefixIcon: Icon(Icons.star_border_outlined),
                      ),
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff132B35),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.borderRadiusLg),
                          ),
                        ),
                        child: const Text(
                          "회원 가입",
                          style: TextStyle(
                            fontSize: TSizes.fontSizeMd,
                            color: Colors.white,
                          ),
                        ),
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
