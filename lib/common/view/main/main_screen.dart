import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/component/weather.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/common/view/main/widget/carwash_life_list_widget.dart';
import 'package:carwash/common/view/main/widget/event_list_widget.dart';
import 'package:carwash/common/view/main/widget/most_registration_product_list_widget.dart';
import 'package:carwash/common/view/main/widget/recent_carwash_list_widget.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:carwash/user/provider/favorite_provider.dart';
import 'package:carwash/user/view/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../weather/provider/weather_provider.dart';

class MainScreen extends ConsumerStatefulWidget {
  static String get routeName => '/';
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(WeatherProvider.notifier).getWeather();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(WeatherProvider);
    ref.read(favoriteProvider.notifier).getFavorites();
    ref.read(hotAllCommunityProvider.notifier).getHotAll();

    return DefaultLayoutV2(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            children: [

              const SizedBox(height: TSizes.spaceBtwItems),

              /// ----------------------------------------------------------------
              /// 상단 정보
              /// ----------------------------------------------------------------
              Row(
                children: [
                  const TRoundedImage(
                    imageUrl: 'asset/img/app_logo_v2.png',
                    width: 54,
                    height: 54,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '세차노트',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: TSizes.sm),
                      Row(
                        children: [
                          Text(
                            '세차한지 ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '12일',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: PRIMARY_COLOR),
                          ),
                          Text(
                            '이 지났어요!',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),


              /// ----------------------------------------------------------------
              /// 날씨 정보
              /// ----------------------------------------------------------------
              _WeatherListWidget(context, state),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),


              /// ----------------------------------------------------------------
              /// 이벤트
              /// ----------------------------------------------------------------
              const EventListWidget(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),


              /// ----------------------------------------------------------------
              /// 최근 세차
              /// ----------------------------------------------------------------
              const RecentCarWashListWidget(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),


              /// ----------------------------------------------------------------
              /// 세차 라이프
              /// ----------------------------------------------------------------
              const CarWashLifeListWidget(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),

              /// ----------------------------------------------------------------
              /// 인기 등록 용품
              /// ----------------------------------------------------------------
              const MostRegistrationProductListWidget(),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),


              /// ----------------------------------------------------------------
              /// 내 주변 세차장 찾기
              /// ----------------------------------------------------------------
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                backgroundColor: const Color(0xffD3F2FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Iconsax.search_status),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '내 주변 세차장 찾기',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '지도에서 내 주변 세차장을 찾아보세요.',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff9E9E9E)),
                        ),
                      ],
                    ),
                    const Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),


              /// ----------------------------------------------------------------
              /// 세차 궁금해요
              /// ----------------------------------------------------------------
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '세차 궁금해요',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: TSizes.xs),
                          Text(
                            '세차에 대해 질문하고 답해봐요',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
                          ),
                        ],
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //
                      //   },
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         '더보기',
                      //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                      //       ),
                      //       const Icon(
                      //         Icons.keyboard_arrow_right,
                      //         color: Colors.blue,
                      //         size: 20,
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// ----------------------------------------------------------------
                  /// 세차 질문 리스트
                  /// ----------------------------------------------------------------
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: TSizes.md),
                      itemBuilder: (BuildContext context, int index) {
                        return TRoundedContainer(
                          padding: const EdgeInsets.all(TSizes.md),
                          // height: 80,
                          showBorder: true,
                          borderColor: const Color(0xffDADADA),
                          radius: 10.0,
                          child: Row(
                            children: [
                              const Icon(Iconsax.message_question),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '세차는 얼마만에 하시나요?',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: TSizes.xs),
                                    Text(
                                      '좋아요 3 · 댓글 10',
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff9E9E9E)),
                                    ),
                                  ],
                                ),
                              ),
                              const TRoundedImage(
                                imageUrl: 'asset/img/car_image.jpeg',
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                                borderRadius: 0,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),

              /// ----------------------------------------------------------------
              /// 인기 세차장
              /// ----------------------------------------------------------------
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '인기 세차장',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: TSizes.xs),
                          Text(
                            '요즘 핫한 세차장은 여기!',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              '더보기',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// ----------------------------------------------------------------
                  /// 인기 세차장 리스트
                  /// ----------------------------------------------------------------
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            TRoundedContainer(
                              width: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //사진
                                  const TRoundedImage(
                                    imageUrl: 'asset/img/carwash180.GIF',
                                    fit: BoxFit.fill,
                                    height: 200,
                                    borderRadius: 0,
                                  ),

                                  const SizedBox(height: TSizes.md),

                                  Text(
                                    'CAR WASH 180 셀프세차장',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: TSizes.xs),
                                  Text(
                                    '부산 강서구 생곡산단1로5번길 7',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: TSizes.xs),
                                  Text(
                                    '등록 10 · 추천 10 · 댓글 10',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: const Color(0xff9E9E9E)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),

              /// ----------------------------------------------------------------
              /// 실시간 투표
              /// ----------------------------------------------------------------
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '실시간 투표',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: TSizes.xs),
                          Text(
                            '요즘 핫한 주제에 대해 투표해 보세요',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              '더보기',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// ----------------------------------------------------------------
                  /// 실시간 투표
                  /// ----------------------------------------------------------------
                  TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                    backgroundColor: const Color(0xffE5FDEB),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Iconsax.chart_1),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '실시간 투표 작성하기',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '핫한 주제를 등록해 보세요',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff9E9E9E)),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                child: Divider(thickness: 3, color: Color(0xffFAFAFA)),
              ),

              /// ----------------------------------------------------------------
              /// 함께 세차하실래요
              /// ----------------------------------------------------------------
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '함께 세차하실래요',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: TSizes.xs),
                          Text(
                            '우리동네 회원들과 같이 세차해요',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              '더보기',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// ----------------------------------------------------------------
                  /// 함께 세차 리스트
                  /// ----------------------------------------------------------------
                  SizedBox(
                    height: 500,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: TSizes.md),
                      itemBuilder: (BuildContext context, int index) {
                        return TRoundedContainer(
                          padding: const EdgeInsets.all(TSizes.md),
                          // height: 80,
                          showBorder: true,
                          borderColor: const Color(0xffDADADA),
                          radius: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TRoundedContainer(
                                    padding: const EdgeInsets.all(TSizes.sm),
                                    radius: 10,
                                    backgroundColor: const Color(0xffF5F5F5),
                                    child: Text(
                                      '부산 강서구 대연동',
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                  ),
                                  const SizedBox(width: TSizes.sm),
                                  TRoundedContainer(
                                    padding: const EdgeInsets.all(TSizes.sm),
                                    radius: 10,
                                    backgroundColor: const Color(0xffFFF2DA),
                                    child: Text(
                                      '참여 4명',
                                      style: Theme.of(context).textTheme.labelLarge,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: TSizes.sm),
                              Text(
                                '세차 초보입니다. 알려주시면서 하실 분 찾아요!',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: TSizes.sm),
                              Text(
                                '오후 09:00 · 쓰리존 카워시',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff9E9E9E)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _WeatherListWidget(context, state) {

  return state.containsKey('weatherInfo') == true
      ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/img/weather_best.png',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text(
                  '오늘 날씨를 확인하고 세차해요!',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              showBorder: true,
              height: 200,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (_, int index) {
                  return Weather(
                    weatherInfo: state['weatherInfo'][index],
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
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const CircularProgressIndicator()
            ],
          ),
        );
}

AppBar renderAppBar(_context) {
  return AppBar(
    // 뒤로가기 버튼 제외
    automaticallyImplyLeading: false,
    backgroundColor: PRIMARY_COLOR,
    title: const Padding(
      padding: EdgeInsets.only(left: TSizes.md),
      child: Text(
        '세차노트',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
    actions: [
      // IconButton(
      //   onPressed: () {},
      //   icon: const Icon(
      //     // Icons.notifications_none_outlined,
      //     Iconsax.notification_bing,
      //     color: Colors.white,
      //   ),
      // ),
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
