import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/user/model/myProductDto.dart';
import 'package:flutter/material.dart';

import '../../../../common/component/rounded_image.dart';
import '../../../../common/const/sizes.dart';

/// -----------------------------------------------------
/// 나의 세차 용품 리스트에 나오는 카드 위젯
/// -----------------------------------------------------
class MyProductsListWidget extends StatelessWidget {
  MyProductDto item;
  MyProductsListWidget({
    super.key,
    required this.item
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
                item.category!,
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
              imageUrl: item.imgUrl!,
              width: 100,
              height: 100,
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: 0,
              isNetworkImage: true,
            ),

            const SizedBox(width: TSizes.spaceBtwItems),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 세차용품 이름 
                Container(
                  width: MediaQuery.of(context).size.width*0.55,
                  child: Text(
                    item.productName!,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                /// 세차용품 최근 사용한 날짜 , 최근 사용날짜 미정으로 카테고릴 값으로 대체
                Container(
                  width: MediaQuery.of(context).size.width*0.55,
                  child: Text(
                    '카테고리 : '+item.category!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                
                /// 세차용품 사용 주기
                Text(
                  '사용주기 : '+item.cycle!,
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