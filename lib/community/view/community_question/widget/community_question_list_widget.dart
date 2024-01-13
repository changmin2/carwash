import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import '../../../../common/component/rounded_container.dart';
import '../../../../common/component/rounded_image.dart';
import '../../../../common/const/sizes.dart';
import '../../../model/community_model.dart';
import '../../community_detail_screen_bak.dart';

class TCommunityQuestionListWidget extends StatelessWidget {
  final CommunityModel model;
  const TCommunityQuestionListWidget({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.goNamed(CommunityDetailScreenBak.routeName,
            pathParameters: {'id':model.id.toString()});
      },
      child: Column(
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
            moreStyle: const TextStyle(color: Colors.grey),
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
          const SizedBox(height: TSizes.spaceBtwItems),
          const Divider(thickness: 1),
          const SizedBox(height: TSizes.spaceBtwItems)
        ],
      ),
    );
  }
}