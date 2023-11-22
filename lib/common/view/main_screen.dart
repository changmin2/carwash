import 'package:carwash/common/component/carwash_life_card.dart';
import 'package:carwash/common/component/event_card.dart';
import 'package:carwash/common/component/recent_carwash_card.dart';
import 'package:carwash/common/component/weather.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../weather/provider/weather_provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(WeatherProvider);
    final sysWidth = MediaQuery.of(context).size.width;


    return DefaultLayoutV2(
        backgroundColor: PRIMARY_COLOR,
        appBar: renderAppBar(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.md),

            /// 상단 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton.icon(
                    // 텍스트버튼에 아이콘 넣기
                    onPressed: () {},
                    icon: const Icon(
                      Icons.airport_shuttle,
                      color: Colors.deepOrangeAccent,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.only(left: TSizes.sm),
                      child: Text('세차기록'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: OutlinedButton.icon(
                    // 텍스트버튼에 아이콘 넣기
                    onPressed: () {},
                    icon: const Icon(
                      Icons.family_restroom_outlined,
                      color: Colors.deepOrangeAccent,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.only(left: TSizes.sm),
                      child: Text('커뮤니티'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

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
                        /// 날씨 정보
                        state.length != 0
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.handshake,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        '오늘은 세차하기 좋은 날이에요!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Container(
                                      height: 180,
                                      child: ListView.builder(
                                        itemCount: state[0].list.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Weather(
                                              weatherInfo: state[0].list[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    Text(
                                      '날씨 정보 불러오는중...',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25),
                                    ),
                                    SizedBox(height: 30),
                                    CircularProgressIndicator()
                                  ],
                                )),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// 이벤트
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: EventCard(
                                  index: index,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// 세차 라이프
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '세차 라이프',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See all',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: 7,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: CarWashLife());
                            },
                          ),
                        ),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '최근 세차',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'See all',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        SizedBox(
                          height: 270,
                          child: ListView.builder(
                            itemCount: 7,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: RecentCarWashCard());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

AppBar renderAppBar(context) {
  return AppBar(
    // 뒤로가기 버튼 제외
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.only(left: TSizes.md),
      child: Text(
        '세차파트너',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications_none_outlined,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.list,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: TSizes.md),
    ],
  );
}
