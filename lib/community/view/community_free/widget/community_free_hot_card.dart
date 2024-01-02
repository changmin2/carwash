import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

class TCommunityFreeHotCard extends StatelessWidget {

  final String imageUrl, title;
  final bool isNetworkImage;

  const TCommunityFreeHotCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: TRoundedContainer(
        width: 120,
        child: Column(
          children: [
            /// 사진
            TRoundedImage(
              imageUrl: imageUrl,
              height: 120,
              fit: BoxFit.fill,
              borderRadius: 8.0,
              isNetworkImage: isNetworkImage,
            ),

            const SizedBox(height: TSizes.sm),

            Column(
              children: [
                /// 글 내용
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
