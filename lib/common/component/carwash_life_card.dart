import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../car/view/record_detail_screen.dart';

class CarWashLife extends StatelessWidget {
  const CarWashLife({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                            '세린이',
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
                            '120',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: TSizes.md),

                  /// 글 내용
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        THelperFunctions.truncateText('오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.', 15),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
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
