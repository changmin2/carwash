import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/view/community_recent_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../car/view/record_detail_screen.dart';
import '../../community/view/community_detail_screen.dart';

class CarWashLife extends StatelessWidget {
  final CommunityModel model;
  const CarWashLife({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        THelperFunctions.navigateToScreen(
          context,
          CommunityRecentScreen(
            model: model,
            flag: 1,
          ),
        );
      },
      child: Row(
        children: [
          TRoundedContainer(
            width: 250,
            radius: 10.0,
            showBorder: true,
            padding: const EdgeInsets.all(TSizes.sm),
            borderColor: const Color(0xffDADADA),
            child: Column(
              children: [
                //사진
                TRoundedImage(
                  imageUrl: model.imgUrls.toString().split(",")[0].split("[")[1].split("]")[0],
                  fit: BoxFit.fill,
                  height: 200,
                  width: double.infinity,
                  isNetworkImage: true,
                  borderRadius: 10.0,
                ),

                const SizedBox(height: TSizes.md),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 닉네임
                          Row(
                            children: [
                              const Icon(
                                Icons.face,
                                size: 20,
                              ),
                              const SizedBox(width: TSizes.xs),
                              Text(
                                model.creator,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),

                          /// 좋아요 갯수
                          Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: TSizes.xs),
                              Text(
                                model.favorite.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: TSizes.sm),

                      /// 글 내용
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              THelperFunctions.truncateText(model.content, 15),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwItems),
        ],
      ),
    );
  }
}
