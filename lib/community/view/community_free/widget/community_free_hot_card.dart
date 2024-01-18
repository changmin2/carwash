import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../model/community_model.dart';
import '../../community_detail_screen_bak.dart';
import '../../community_recent_screen.dart';

class TCommunityFreeHotCard extends StatelessWidget {

  final String imageUrl, title;
  final bool isNetworkImage;
  final CommunityModel model;

  const TCommunityFreeHotCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.model,
    this.isNetworkImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityRecentScreen(model: model,freeOrall: false,flag: 2,)));
      },
      child: TRoundedContainer(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
