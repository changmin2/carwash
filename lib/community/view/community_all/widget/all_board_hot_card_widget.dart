import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCommunityAllHotCardWidget extends StatelessWidget {
  final String imageUrl, nickName, likeCount, title, replyCount,commentCnt;
  final bool isNetworkImage;
  final double containerWidth;
  final double imageHeight;

  const TCommunityAllHotCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.nickName,
    required this.containerWidth,
    required this.imageHeight,
    required this.commentCnt,
    this.isNetworkImage = false,
    this.likeCount = '0',
    this.replyCount = '0',
  });

  @override
  Widget build(BuildContext context) {

    return TRoundedContainer(
      width: containerWidth,
      radius: 12.0,
      showBorder: true,
      padding: const EdgeInsets.all(TSizes.sm),
      child: Column(
        children: [
          /// 사진
          TRoundedImage(
            imageUrl: imageUrl,
            height: imageHeight,
            fit: BoxFit.fill,
            borderRadius: 12.0,
            isNetworkImage: isNetworkImage,
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 제목
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),

                const SizedBox(height: TSizes.spaceBtwItems / 2),

                /// 닉네임 and 좋아요갯수 and 리플갯수
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    /// 닉네임
                    Container(
                      width: 90,
                      child: Text(
                        nickName,
                        style: Theme.of(context).textTheme.labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    /// 좋아요 갯수
                    Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Iconsax.like_1,
                              size: 16,
                            ),
                            const SizedBox(width: TSizes.xs),
                            Text(
                              likeCount,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),

                        const SizedBox(width: TSizes.sm),

                        /// 리플갯수
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Iconsax.message4,
                              size: 16,
                            ),
                            const SizedBox(width: TSizes.xs),
                            Text(
                              commentCnt,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
