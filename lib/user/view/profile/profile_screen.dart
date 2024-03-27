import 'package:carwash/car/provider/myrecord_provider.dart';
import 'package:carwash/car/view/register_first_screen.dart';
import 'package:carwash/car/view/register_second_screen.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/user/model/user_model.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:carwash/user/view/profile/widget/setting_menu_tile.dart';
import 'package:carwash/user/view/profile/widget/user_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/appbar.dart';
import '../edit_user_screen.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static get routeName => 'userProfileScreen';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {

  @override
  Widget build(BuildContext context) {
    var record = ref.read(MyRecordProvider);
    final state = ref.watch(userMeProvider) as UserModel;
    print(record);
    return DefaultLayoutV2(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Profile Tile
            TUserProfileTile(title: state.nickname, subtitle: "1단계 환자"),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Setting List
            Container(
              height: THelperFunctions.screenHeight(context),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Setting Menus
                  //const TSettingsMenuTile(icon: Iconsax.box, title: "나의 장비", subTitle: '나만의 장비를 등록하고 관리해보세요!'),

                  GestureDetector(
                    onTap: () {

                      record.length != 0
                      ?
                      THelperFunctions.navigateToScreen(
                        context,
                        RecordSecondScreen(
                          flag: 2,
                        ),
                      )
                      :
                      THelperFunctions.navigateToScreen(
                        context,
                        RecordFirstScreen(
                          flag: 1,
                        ),
                      );
                    },
                    child: const TSettingsMenuTile(icon: Iconsax.calendar_edit, title: "나의 세차 루트", subTitle: '자주 사용하는 세차 루트를 등록해 보세요!'),
                  ),

                  //const TSettingsMenuTile(icon: Iconsax.notification_bing, title: "알림 설정", subTitle: '알고 싶은 내용만 알림이 오게 관리해보세요!'),

                  const TSettingsMenuTile(icon: Iconsax.notification_1, title: "문의사항은 아래의 이메일로 문의해주세요.", subTitle: 'dlckdals9467@naver.com'),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Logout Button
                  Container(
                    padding: const EdgeInsets.only(top: TSizes.defalutSpace, left: TSizes.defalutSpace, right: TSizes.defalutSpace),
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                        color: Colors.black,
                      )),
                      onPressed: () => ref.read(userMeProvider.notifier).logout(),
                      child: const Text("로그아웃"),
                    ),
                  ),

                  /// 회원탈퇴
                  Container(
                    padding: const EdgeInsets.only(top: 8, left: TSizes.defalutSpace, right: TSizes.defalutSpace),
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[new Text("회원탈퇴")],
                              ),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[Text("정말 회원탈퇴를 하시겠습니까?")],
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('취소')),
                                TextButton(
                                    onPressed: () async {
                                      await ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('회원탈퇴 완료'),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                      await ref.read(userMeProvider.notifier).withDrawl();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('확인'))
                              ],
                            );
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      child: const Text(
                        '회원탈퇴',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
