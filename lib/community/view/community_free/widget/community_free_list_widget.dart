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
                        child: Text('HOT', style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.redAccent)),
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
                : const SizedBox(),

            /// 날짜
            Text(date, style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// 제목
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// 유저사진, 닉네임, 좋아요, 댓글
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 유저사진
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
            Text(nickName, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: TSizes.sm),

            Text('|', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: TSizes.sm),

            /// 추천
            const Icon(Iconsax.like_1, size: 14),
            const SizedBox(width: TSizes.xs),
            Text('$likeCount', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: TSizes.sm),

            Text('|', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: TSizes.sm),

            /// 댓글
            const Icon(Iconsax.message4, size: 14),
            const SizedBox(width: TSizes.xs),
            Text('$replyCount', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
