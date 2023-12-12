import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/common/widgets/appbar.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
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
    return DefaultLayoutV2(
      backgroundColor: PRIMARY_COLOR,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TAppbar(
              backButtonColor: Colors.white,
            ),
            ListTile(
              leading: const Image(
                image: AssetImage('asset/img/naver_logo.png'),
                width: 50,
                height: 50,
              ),
              title: Text(
                '유상용111',
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white),
              ),
              subtitle: Text(
                'rsy0921@naver.com',
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.edit,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// 설정 목록
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
                  const ListTile(
                    leading: Icon(
                      Iconsax.icon,
                      size: 28,
                      color: PRIMARY_COLOR,
                    ),
                    title: Text('나의 장비'),
                    subtitle: Text('나만의 장비를 등록하고 관리해보세요!'),
                  ),
                  const ListTile(
                    leading: Icon(
                      Iconsax.activity,
                      size: 28,
                      color: PRIMARY_COLOR,
                    ),
                    title: Text('알림 설정'),
                    subtitle: Text('알고 싶은 내용만 알림이 오게 관리해보세요!'),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
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
                      child: const Text("LOGOUT"),
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
