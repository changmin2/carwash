import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/component/rounded_container.dart';

class TCommunityFreeListWidget extends StatelessWidget {
  final String title, nickName, date, imageUrl, hashtag;
  final int likeCount, replyCount;
  final bool isNetworkImage, hotYn;

  const TCommunityFreeListWidget({
    super.key,
    required this.title,
    required this.nickName,
    required this.date,
    this.likeCount = 0,
    this.replyCount = 0,
    this.hashtag = "",
    this.imageUrl = "",
    this.isNetworkImage = false,
    this.hotYn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            /// 핫한 글 표시
            hotYn
                ? Row(
                    children: [
                      TRoundedContainer(
                        padding: const EdgeInsets.all(TSizes.xs),
                        showBorder: true,
                        radius: 6,
                        borderColor: Colors.redAccent,
                        backgroundColor: Colors.redAccent,
                        child: Text('HOT', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)),
                      ),
                      const SizedBox(width: TSizes.sm),
                    ],
                  )
                : const SizedBox(),

            /// 해시태그
            hashtag.isNotEmpty
                ? Row(
                    children: [
                      TRoundedContainer(
                        padding: const EdgeInsets.all(TSizes.xs),
                        showBorder: true,
                        radius: 6,
                        child: Text('#$hashtag', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
                      ),
                      const SizedBox(width: TSizes.sm),
                    ],
                  )
                : const SizedBox(width: 16),

            /// 날짜
            Text(date, style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// 제목
        Text(title, style: Theme.of(context).textTheme.bodyMedium),

        const SizedBox(height: TSizes.spaceBtwItems * 2),

        /// 유저사진, 닉네임, 좋아요, 댓글
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 유저사진
            Row(
              children: [
                imageUrl.isNotEmpty
                    ? TRoundedImage(
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                        imageUrl: imageUrl,
                        borderRadius: 100,
                        isNetworkImage: isNetworkImage,
                      )
                    : const Icon(Iconsax.user_octagon, size: 24),
                const SizedBox(width: TSizes.sm),

                /// 닉네임
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.49,
                  child: Text(
                    nickName,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            /// 좋아요 and 댓글
            Row(
              children: [
                Text('좋아요', style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(width: TSizes.xs),
                Text('$likeCount', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.redAccent)),
                const SizedBox(width: TSizes.spaceBtwItems),

                /// 댓글
                Text('댓글', style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(width: TSizes.xs),
                Text('$replyCount', style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.blueAccent)),
              ],
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        const Divider(thickness: 0.5),
      ],
    );
  }
}
