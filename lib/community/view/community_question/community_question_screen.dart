import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_free/widget/community_free_hot_card.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class TCommunityQuestionScreen extends StatelessWidget {
  const TCommunityQuestionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [
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
                  return TCommunityQuestionListWidget();
                }),
          ],
        ),
      ),
    );
  }
}

class TCommunityQuestionListWidget extends StatelessWidget {
  const TCommunityQuestionListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('2023.12.21', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        const ReadMoreText(
          '저는 세차를 시작한지 얼마 되지 않았습니다. 그래서 모르는 게 많아요. 프리워시를 하고 나서 바로 폼을 뿌리나요? 아니면 프리워시하고 고압수를 하고 폼을 뿌리나요? 뭐가 더 나은지 잘 모르겠습니다.',
          trimLines: 3,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' 더보기',
          moreStyle: TextStyle(color: Colors.grey),
          trimExpandedText: '',
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        Row(
          children: [
            TRoundedContainer(
              padding: const EdgeInsets.all(6.0),
              showBorder: true,
              borderColor: Colors.indigoAccent,
              radius: 6,
              child: Text(
                '#세차순서',
                style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.indigoAccent),
              ),
            ),

            const SizedBox(width: TSizes.spaceBtwItems / 2),

            TRoundedContainer(
              padding: const EdgeInsets.all(6.0),
              showBorder: true,
              borderColor: Colors.indigoAccent,
              radius: 6,
              child: Text(
                '#프리워시종류',
                style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.indigoAccent),
              ),
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
              ],
            ),

            Text(
              '댓글 10개',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
