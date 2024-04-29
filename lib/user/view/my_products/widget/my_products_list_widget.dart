import 'package:carwash/common/component/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../common/component/rounded_image.dart';
import '../../../../common/const/sizes.dart';

/// -----------------------------------------------------
/// 나의 세차 용품 리스트에 나오는 카드 위젯
/// -----------------------------------------------------
class MyProductsListWidget extends StatelessWidget {
  const MyProductsListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        /// 사용자가 등록한 카테고리 이름(ex: 카샴푸, 휠브러쉬)
        Row(
          children: [
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.sm),
              showBorder: true,
              radius: 6,
              borderColor: Colors.blueAccent,
              backgroundColor: Colors.blueAccent,
              child: Text(
                '카샴푸',
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
              ),
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),
        
        /// 세차용품 이미지
        Row(
          children: [
            TRoundedImage(
              imageUrl: 'asset/img/no_image.png',
              width: 100,
              height: 100,
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: 0,
            ),

            const SizedBox(width: TSizes.spaceBtwItems),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 세차용품 이름 
                Text(
                  '카프로 리셋 카샴푸',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                /// 세차용품 최근 사용한 날짜 
                Text(
                  '최근 사용일자 : 2024.04.24',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                
                /// 세차용품 사용 주기
                Text(
                  '사용주기 : 매번',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}