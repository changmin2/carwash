import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

import '../../component/rounded_container.dart';
import '../../layout/default_layout_v2.dart';

class DilutionScreen extends StatelessWidget {
  const DilutionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "물 용량",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: PRIMARY_COLOR),
                ),
                Text(
                  "을 입력하시면 ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "희석비율",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: PRIMARY_COLOR),
                ),
                Text(
                  "에 맞춰",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "케미컬 용량",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.redAccent),
                ),
                Text(
                  "을 계산하여 보여줍니다.",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// 물용량 라벨
            Text(
              '물 용량(ml)',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// 세차일자
            TRoundedContainer(
              showBorder: true,
              child: ListTile(
                title: Text(
                  "1500",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// 희석비율 라벨
            Text(
              '희석 비율(1:500 이면 500 입력)',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// 희석비율
            TRoundedContainer(
              showBorder: true,
              child: ListTile(
                title: Text(
                  "30",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// 케미컬 용량 계산 하기 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("케미컬 용량 계산하기"),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// 희석비율
            TRoundedContainer(
              width: double.infinity,
              radius: TSizes.buttonRadius,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: const Color(0xff2F80ED),
              child: Column(
                children: [
                  Text(
                    "케미컬 용량",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "50",
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "ml",
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                    ],
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
