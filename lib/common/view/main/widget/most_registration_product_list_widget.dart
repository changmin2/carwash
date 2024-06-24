import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MostRegistrationProductListWidget extends StatelessWidget {
  const MostRegistrationProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final containerWidth = (THelperFunctions.screenWidth(context) - (20 * 2) - 16) / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '인기 등록 용품',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: TSizes.xs),

        Text(
          '회원님이 세차한 기록이에요',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedContainer(
              width: containerWidth,
              padding: const EdgeInsets.all(TSizes.sm),
              showBorder: true,
              borderColor: const Color(0xffDADADA),
              radius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const TRoundedImage(
                        width: 134,
                        height: 134,
                        imageUrl: 'asset/img/best_car_goods_01.png',
                      ),
                      TRoundedContainer(
                        showBorder: true,
                        borderColor: PRIMARY_COLOR,
                        padding: const EdgeInsets.all(TSizes.sm),
                        radius: 10,
                        child: Text(
                          '카샴푸',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: PRIMARY_COLOR),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm),
                  TRoundedContainer(
                    width: 134,
                    backgroundColor: const Color(0xffFFF2DA),
                    padding: const EdgeInsets.all(TSizes.sm),
                    radius: 10,
                    child: Text(
                      '100명 등록!',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffFF5500)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    '카프로 리셋 카샴푸',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(width: TSizes.spaceBtwItems),

            TRoundedContainer(
              width: containerWidth,
              padding: const EdgeInsets.all(TSizes.sm),
              showBorder: true,
              borderColor: const Color(0xffDADADA),
              radius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const TRoundedImage(
                        width: 134,
                        height: 134,
                        imageUrl: 'asset/img/best_car_goods_01.png',
                      ),
                      TRoundedContainer(
                        showBorder: true,
                        borderColor: PRIMARY_COLOR,
                        padding: const EdgeInsets.all(TSizes.sm),
                        radius: 10,
                        child: Text(
                          '카샴푸',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: PRIMARY_COLOR),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm),
                  TRoundedContainer(
                    width: 134,
                    backgroundColor: const Color(0xffFFF2DA),
                    padding: const EdgeInsets.all(TSizes.sm),
                    radius: 10,
                    child: Text(
                      '100명 등록!',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffFF5500)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    '카프로 리셋 카샴푸',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedContainer(
              width: containerWidth,
              padding: const EdgeInsets.all(TSizes.sm),
              showBorder: true,
              borderColor: const Color(0xffDADADA),
              radius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const TRoundedImage(
                        width: 134,
                        height: 134,
                        imageUrl: 'asset/img/best_car_goods_01.png',
                      ),
                      TRoundedContainer(
                        showBorder: true,
                        borderColor: PRIMARY_COLOR,
                        padding: const EdgeInsets.all(TSizes.sm),
                        radius: 10,
                        child: Text(
                          '카샴푸',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: PRIMARY_COLOR),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm),
                  TRoundedContainer(
                    width: 134,
                    backgroundColor: const Color(0xffFFF2DA),
                    padding: const EdgeInsets.all(TSizes.sm),
                    radius: 10,
                    child: Text(
                      '100명 등록!',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffFF5500)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    '카프로 리셋 카샴푸',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(width: TSizes.spaceBtwItems),

            TRoundedContainer(
              width: containerWidth,
              padding: const EdgeInsets.all(TSizes.sm),
              showBorder: true,
              borderColor: const Color(0xffDADADA),
              radius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const TRoundedImage(
                        width: 134,
                        height: 134,
                        imageUrl: 'asset/img/best_car_goods_01.png',
                      ),
                      TRoundedContainer(
                        showBorder: true,
                        borderColor: PRIMARY_COLOR,
                        padding: const EdgeInsets.all(TSizes.sm),
                        radius: 10,
                        child: Text(
                          '카샴푸',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: PRIMARY_COLOR),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.sm),
                  TRoundedContainer(
                    width: 134,
                    backgroundColor: const Color(0xffFFF2DA),
                    padding: const EdgeInsets.all(TSizes.sm),
                    radius: 10,
                    child: Text(
                      '100명 등록!',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xffFF5500)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),
                  Text(
                    '카프로 리셋 카샴푸',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// 다음 단계 버튼
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffF5F5F5),
              surfaceTintColor: Colors.white,
              elevation: 0,
              side: const BorderSide(color: Colors.transparent),
            ),
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '전체보기',
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.keyboard_arrow_right, color: Colors.black,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
