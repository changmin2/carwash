import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_free/widget/community_free_hot_card.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCommunityFreeScreen extends StatelessWidget {
  const TCommunityFreeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [
            /// HOT 자유게시판
            /// HOT section header
            const TCommunitySectionHeading(
              firstTitle: 'HOT',
              firstTitleColor: Colors.red,
              secondTitle: '자유게시판',
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// HOT 전체 리스트
            SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: TSizes.sm),
                    child: TCommunityFreeHotCard(
                      imageUrl: 'asset/img/car_image.jpeg',
                      title: '오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.',
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            const Divider(thickness: 1),

            const SizedBox(height: TSizes.spaceBtwItems),

            ListView.separated(
                itemCount: 5,
                // 리스트에 해당되는 영역만 차지
                shrinkWrap: true,
                // 스크롤이 되지 않게.
                primary: false,
                separatorBuilder: (_, index) {
                  return const Column(
                    children: [
                      SizedBox(height: TSizes.spaceBtwItems),
                      Divider(thickness: 1),
                      SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  );
                },
                itemBuilder: (_, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.xs),
                            showBorder: true,
                            radius: 6,
                            borderColor: Colors.redAccent,
                            child: Text(
                              'HOT',
                              style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.redAccent),
                            ),
                          ),
                          const SizedBox(width: TSizes.sm),
                          TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.xs),
                            showBorder: true,
                            radius: 6,
                            child: Text(
                              '#세차방법공유',
                              style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: TSizes.sm),
                          Text('2023.12.21', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      Text('세차 하는 진정한 방법을 가르쳐 주겠다!', style: Theme.of(context).textTheme.bodyMedium,),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TRoundedImage(
                            width: 30,
                            height: 30,
                            fit: BoxFit.fill,
                            imageUrl: 'asset/img/car_image.jpeg',
                            borderRadius: 100,
                          ),

                          const SizedBox(width: TSizes.sm),

                          Text('세차환자', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: TSizes.sm),
                          Text('|', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: TSizes.sm),

                          const Icon(
                            Iconsax.like_1,
                            size: 14,
                          ),
                          // Text(
                          //   '추천',
                          //   style: Theme.of(context).textTheme.bodySmall,
                          // ),
                          const SizedBox(width: TSizes.xs),
                          Text(
                            '10',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: TSizes.sm),
                          Text('|', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: TSizes.sm),
                          const Icon(
                            Iconsax.message4,
                            size: 14,
                          ),

                          // Text(
                          //   '댓글',
                          //   style: Theme.of(context).textTheme.bodySmall,
                          // ),
                          const SizedBox(width: TSizes.xs),
                          Text(
                            '10',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
