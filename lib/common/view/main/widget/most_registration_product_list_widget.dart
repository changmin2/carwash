import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MostRegistrationProductListWidget extends StatelessWidget {
  const MostRegistrationProductListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '최다 등록 용품',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(''),
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        SizedBox(
          height: 300,
          child: ListView.separated(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: TSizes.sm),
            itemBuilder: (BuildContext context, int index) {

              return TRoundedContainer(
                width: 200,
                padding: const EdgeInsets.all(TSizes.sm),
                showBorder: true,
                borderColor: Colors.grey,
                radius: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        const TRoundedImage(
                          width: 200,
                          height: 200,
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

                    Text(
                      '카프로 리셋 카샴푸',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(height: TSizes.sm),

                    TRoundedContainer(
                      backgroundColor: Colors.yellowAccent,
                      padding: const EdgeInsets.all(TSizes.sm),
                      radius: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.dcube,
                            size: 18,
                            color: Colors.redAccent,
                          ),

                          const SizedBox(width: TSizes.sm),

                          Text(
                            '100명 등록!',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// 다음 단계 버튼
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              side: const BorderSide(color: PRIMARY_COLOR),
            ),
            onPressed: ()  {},
            child: const Text('최다 등록 용품 더보기', style: TextStyle(color: Colors.black),),
          ),
        ),
      ],
    );
  }
}