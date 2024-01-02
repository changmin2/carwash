import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/component/rounded_container.dart';
import '../../../../common/component/rounded_image.dart';
import '../../../../common/const/sizes.dart';

class TCommunityCarWashLifeListWidget extends StatelessWidget {
  TCommunityCarWashLifeListWidget({
    super.key,
  });

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 유저사진, 닉네임, 날짜, 팔로우 버튼
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 유저 사진
              Row(
                children: [
                  const TRoundedImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                    imageUrl: 'asset/img/car_image.jpeg',
                    borderRadius: 100,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),

                  /// 닉네임 날짜
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('세차환자', style: Theme.of(context).textTheme.bodyMedium),
                      Text('2023.12.21', style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ],
              ),

              /// 팔로우 버튼
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.sm),
                radius: 10,
                showBorder: true,
                backgroundColor: Colors.redAccent,
                child: Text(
                  '팔로우',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// 사진
        SizedBox(
          height: 350,
          child: PageView.builder(
            controller: controller,
            itemCount: 3,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, int index) {
              return const TRoundedImage(
                fit: BoxFit.cover,
                imageUrl: 'asset/img/car_image.jpeg',
                borderRadius: 0,
              );
            },
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        Center(
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.black,
              dotHeight: 6,
            ),
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
          child: Row(
            children: [
              Text(
                '추천',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: TSizes.xs),
              Text(
                '10개',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: TSizes.spaceBtwItems / 2),

              Text('|', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: TSizes.spaceBtwItems / 2),

              Text(
                '댓글',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: TSizes.xs),

              Text(
                '10개',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
          child: Text(
            '추운 겨울이 왔네요...너무 너무 추운데 세차는 해야겠더라구요~ 너무 추워서 오늘은 개러지에서 비싼 돈 주고 세차를 했습니다.',
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}