import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCommunityFreeBoardCard extends StatelessWidget {
  final String title, nickName, date, content, imageUrl;
  final bool isNetworkImage;
  final bool attachedImageYn;

  const TCommunityFreeBoardCard({
    super.key,
    required this.title,
    required this.nickName,
    required this.date,
    required this.content,
    this.imageUrl = "",
    this.isNetworkImage = false,
    this.attachedImageYn = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              /// 제목
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: TSizes.sm),
              
              /// 닉네임
              Row(
                children: [
                  Text(
                    nickName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: TSizes.sm),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.md),

              /// 첨부이미지
              attachedImageYn ?
              Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (_, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: TSizes.sm),
                                child: TRoundedImage(
                                  imageUrl: imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.sm),
                ],
              ) : const SizedBox(),

              const SizedBox(height: TSizes.md),
              
              /// 본문
              Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: TSizes.sm),

              const Divider(thickness: 1),

              const SizedBox(height: TSizes.sm),

              /// 추천 and 댓글 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.like_1,
                        size: 15,
                      ),
                      const SizedBox(width: TSizes.xs),
                      Text(
                        '추천 120',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),

                  /// 리플갯수
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Iconsax.message4,
                        size: 20,
                      ),
                      const SizedBox(width: TSizes.xs),
                      Text(
                        '10',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
