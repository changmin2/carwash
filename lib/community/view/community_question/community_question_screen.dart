import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/view/community_free/widget/community_free_hot_card.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';

class TCommunityQuestionScreen extends StatelessWidget {
  const TCommunityQuestionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defalutSpace),
      child: Container(
        child: Column(
            children:[
              Expanded(
                child: PaginationListView(
                    provider: communityProvider,
                    itemBuilder: <CommunityModel>(_,index,community){
                      return TCommunityQuestionListWidget(
                        model: community
                      );
                    }),
              ),]
        ),
      ),
    );
  }
}

class TCommunityQuestionListWidget extends StatelessWidget {
  final CommunityModel model;
  const TCommunityQuestionListWidget({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(model.createDate.split("T")[0], style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        ReadMoreText(
          model.content,
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

                Text(model.creator, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(width: TSizes.sm),
              ],
            ),

            Text(
              '댓글 10개',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Divider(thickness: 1),
        SizedBox(height: TSizes.spaceBtwItems)
      ],
    );
  }
}
