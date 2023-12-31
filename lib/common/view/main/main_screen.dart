import 'package:carwash/car/model/recentRecordDto.dart';
import 'package:carwash/car/repository/record_repository.dart';
import 'package:carwash/common/component/weather.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/common/view/main/widget/carwash_life_list_widget.dart';
import 'package:carwash/common/view/main/widget/event_list_widget.dart';
import 'package:carwash/common/view/main/widget/recent_carwash_list_widget.dart';
import 'package:carwash/common/view/main/widget/top_menu_widget.dart';
import 'package:carwash/user/model/user_model.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:carwash/user/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../weather/provider/weather_provider.dart';


class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // // 스테이터스바 백그라운드컬러
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle().copyWith(statusBarColor: PRIMARY_COLOR),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(WeatherProvider);
    return DefaultLayoutV2(
      appBar: renderAppBar(context),
      backgroundColor: PRIMARY_COLOR,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          const SizedBox(height: TSizes.md),

          /// ----------------------------------------------------------------
          /// 세차기록, 커뮤니티 메뉴 버튼 영역
          /// ----------------------------------------------------------------
          const TopMenuWidget(),
          const SizedBox(height: TSizes.spaceBtwSections),
          /// ----------------------------------------------------------------


          /// ----------------------------------------------------------------
          /// 컨텐츠 영역
          /// ----------------------------------------------------------------
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.defalutSpace),
                  child: Column(
                    children: [
                      /// ----------------------------------------------------------------
                      /// 날씨 정보
                      /// ----------------------------------------------------------------
                      state.length != 0
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'asset/img/weather_best.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    const SizedBox(width: TSizes.spaceBtwItems),
                                    Text(
                                      '오늘은 세차하기 좋은 날이에요!',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    )
                                  ],
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                SizedBox(
                                  height: 130,
                                  child: ListView.builder(
                                    itemCount: state[0].list.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Weather(
                                          weatherInfo: state[0].list[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 130,
                              child: Column(
                                children: [
                                  Text(
                                    '날씨 정보 불러오는중...',
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  const CircularProgressIndicator()
                                ],
                              ),
                            ),

                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// ----------------------------------------------------------------
                      /// 이벤트
                      /// ----------------------------------------------------------------
                      const EventListWidget(),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// ----------------------------------------------------------------
                      /// 세차 라이프
                      /// ----------------------------------------------------------------
                      const CarWashLifeListWidget(),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// ----------------------------------------------------------------
                      /// 최근 세차
                      /// ----------------------------------------------------------------
                      const RecentCarWashListWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

AppBar renderAppBar(_context) {
  return AppBar(
    // 뒤로가기 버튼 제외
    automaticallyImplyLeading: false,
    backgroundColor: PRIMARY_COLOR,
    title: const Padding(
      padding: EdgeInsets.only(left: TSizes.md),
      child: Text(
        '세차파트너',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          // Icons.notifications_none_outlined,
          Iconsax.notification_bing,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {
          THelperFunctions.navigateToScreen(_context, const UserProfileScreen());
        },
        icon: const Icon(
          Iconsax.textalign_justifycenter,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: TSizes.md),
    ],
  );
}
