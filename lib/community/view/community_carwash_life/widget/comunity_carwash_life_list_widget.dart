import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/view/community_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/component/rounded_container.dart';
import '../../../../common/component/rounded_image.dart';
import '../../../../common/const/sizes.dart';
import '../../../model/community_model.dart';

class TCommunityCarWashLifeListWidget extends StatelessWidget {
  final CommunityModel model;
  TCommunityCarWashLifeListWidget({
    required this.model,
    super.key,
  });

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<String> imgs = [];
    if (model.imgUrls != '') {
      imgs = model.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
    }

    return Column(
      children: [
        /// 유저사진, 닉네임, 날짜, 팔로우 버튼
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 유저 사진
                  const TRoundedImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                    imageUrl: 'asset/img/profile_image.png',
                    borderRadius: 100,
                  ),

                  const SizedBox(width: TSizes.spaceBtwItems / 2),

                  /// 닉네임 날짜
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.creator, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: TSizes.xs),
                      Text(model.createDate.split("T")[0], style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ],
              ),

              /// 팔로우 버튼
              GestureDetector(
                onTap: () => THelperFunctions.showAlert(context, '', '업데이트 예정입니다.'),
                child: TRoundedContainer(
                  padding: const EdgeInsets.all(TSizes.sm),
                  radius: 10,
                  // showBorder: true,
                  backgroundColor: Colors.indigoAccent,
                  child: Text(
                    '팔로우',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// 사진
        GestureDetector(
          onTap: () => context.goNamed(CommunityDetailScreen.routeName, pathParameters: {'id': model.id.toString()}),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imgs.isEmpty
                  ? const SizedBox(
                      height: 150,
                      child: Center(
                        child: Text('No Image'),
                      ),
                    )
                  : SizedBox(
                      height: 350,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: imgs.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, int index) {
                          return TRoundedImage(
                            fit: BoxFit.cover,
                            imageUrl: imgs[index].trim(),
                            borderRadius: 0,
                            isNetworkImage: true,
                          );
                        },
                      ),
                    ),
          
              const SizedBox(height: TSizes.spaceBtwItems),
          
              imgs.isEmpty
                  ? Container()
                  : Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: imgs.length,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Colors.black,
                          dotHeight: 6,
                        ),
                      ),
                    ),
          
              const SizedBox(height: TSizes.spaceBtwItems),
          
              /// 좋아요 and 댓글
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
                child: Row(
                  children: [
                    Text(
                      '좋아요',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.redAccent),
                    ),
                    const SizedBox(width: TSizes.xs),
                    Text(
                      "${model.favorite}개",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.redAccent),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
          
                    Text(
                      '댓글',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.blueAccent),
                    ),
                    const SizedBox(width: TSizes.xs),
                    Text(
                      '${model.commentCnt}개',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: TSizes.spaceBtwItems / 2),
          
              /// 작성글
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.defalutSpace),
                child: Text(
                  model.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
