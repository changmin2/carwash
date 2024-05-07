import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

///-------------------------------------------------------
/// 다른 회원 정보 화면의 세차용품 위젯
///-------------------------------------------------------
class MemberInfoCarWashGoodsWidget extends StatelessWidget {
  const MemberInfoCarWashGoodsWidget({
    super.key,
  });

  ///*************************************
  /// 임의로 만든 변수
  ///*************************************
  final int listCnt = 1;
  final String regYn = 'Y';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '세차 용품',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(width: TSizes.sm),
            ///*************************************
            /// 세차 용품 갯수 - 그냥 무조건 숫자 보여줘~
            ///*************************************
            Text(
              '3',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: PRIMARY_COLOR),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// 세차 용품 리스트
        _carWashGoodsList(context),
      ],
    );
  }


  Column _carWashGoodsList(BuildContext context) {

    ///*************************************
    /// 1. 본인 세차용품 등록 X
    ///*************************************
    if (regYn == 'N') {

      return Column(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text(
                '회원님의 세차용품을 먼저 등록해주세요.',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      );

    } else {

      ///*************************************
      /// 2-1. 본인 세차용품 등록 O
      ///      건수가 없으면 없다는 글만.
      ///*************************************
      if (listCnt == 0) {
        return Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  '등록된 세차용품이 없습니다.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        );

      } else {

        ///*************************************
        /// 2-2. 본인 세차용품 등록 O
        ///      건수가 있으면 무조건 두개만 보여주고 버튼
        ///*************************************
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TRoundedContainer(
                  width: (THelperFunctions.screenWidth(context) - 40) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.sm),
                            showBorder: true,
                            borderColor: Colors.blueAccent,
                            radius: 10,
                            child: Text(
                              '카샴푸',
                              style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.blueAccent),
                            ),
                          ),
                          const SizedBox(height: TSizes.sm),
                          TRoundedImage(
                            imageUrl: 'asset/img/no_image.png',
                            width: 140,
                            height: 140,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: 0,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.sm),
                      Text(
                        '카프로 리셋 카샴푸',
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TRoundedContainer(
                  width: (THelperFunctions.screenWidth(context) - 40) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.sm),
                            showBorder: true,
                            borderColor: Colors.blueAccent,
                            radius: 10,
                            child: Text(
                              '물왁스',
                              style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.blueAccent),
                            ),
                          ),
                          const SizedBox(height: TSizes.sm),
                          TRoundedImage(
                            imageUrl: 'asset/img/no_image.png',
                            width: 140,
                            height: 140,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: 0,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.sm),
                      Text(
                        '카티바 웻 왁스',
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            TRoundedContainer(
              width: double.infinity,
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: const Color(0xffF5F5F5),
              child: Text(
                '전체보기',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );

      }
    }
  }



}
