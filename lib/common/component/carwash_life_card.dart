import 'package:carwash/common/component/rounded_container.dart';
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
  const CarWashLife({
    required this.model,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityRecentScreen(model: model,flag: 1,)));
        },
      child: TRoundedContainer(
        width: 230,
        height: 320,
        radius: 12.0,
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Column(
          children: [
            /// 사진
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'asset/img/car_image.jpeg',
                fit: BoxFit.fill,
                height: 200,
              ),
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
                          const Icon(Icons.face),
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

                  const SizedBox(height: TSizes.md),

                  /// 글 내용
                  SizedBox(
                    height: 25,
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
    );
  }
}
