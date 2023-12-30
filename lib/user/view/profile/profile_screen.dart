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

class UserProfileScreen extends ConsumerStatefulWidget {
  static get routeName => 'userProfileScreen';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.read(userMeProvider) as UserModel;
    return DefaultLayoutV2(
      backgroundColor: PRIMARY_COLOR,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Appbar
            // const TAppbar(
            //   backButtonColor: Colors.white,
            // ),
            AppBar(),
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
                  const TSettingsMenuTile(icon: Iconsax.box, title: "나의 장비", subTitle: '나만의 장비를 등록하고 관리해보세요!'),
                  const TSettingsMenuTile(icon: Iconsax.notification_bing, title: "알림 설정", subTitle: '알고 싶은 내용만 알림이 오게 관리해보세요!'),
                  const TSettingsMenuTile(icon: Iconsax.notification_bing, title: "알림 설정", subTitle: '알고 싶은 내용만 알림이 오게 관리해보세요!'),

                  const SizedBox(height: TSizes.spaceBtwSections * 2),
                  
                  /// Logout Button
                  Container(
                    padding: const EdgeInsets.all(TSizes.defalutSpace),
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.black,
                        )
                      ),
                      onPressed: () => ref.read(userMeProvider.notifier).logout(),
                      child: const Text("로그아웃"),
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




