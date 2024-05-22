import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/user/view/member_info/member_all_goods_screen.dart';
import 'package:flutter/material.dart';

import '../../../model/myProductDto.dart';

///-------------------------------------------------------
///-------------------------------------------------------
/// 다른 회원 정보 화면의 세차용품 위젯
///-------------------------------------------------------
///-------------------------------------------------------
class MemberInfoCarWashGoodsWidget extends StatelessWidget {
  final List<MyProductDto> myProduct;
  MemberInfoCarWashGoodsWidget({
    super.key,
    required this.myProduct
  });


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
              myProduct.length.toString(),
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
    if (myProduct.length == -1) {
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
          const SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent),
              ),
              onPressed: () {},
              child: Text(
                '등록하기',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.redAccent),
                textAlign: TextAlign.center,
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
      if (myProduct.length == 0) {
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
                              myProduct[0].category.toString(),
                              style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.blueAccent),
                            ),
                          ),
                          const SizedBox(height: TSizes.sm),
                          TRoundedImage(
                            imageUrl: myProduct[0].imgUrl.toString(),
                            width: 140,
                            height: 140,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: 0,
                            isNetworkImage: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.sm),
                      Text(
                        myProduct[0].productName.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                myProduct.length>1
                ?
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
                              myProduct[1].category.toString(),
                              style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.blueAccent),
                            ),
                          ),
                          const SizedBox(height: TSizes.sm),
                          TRoundedImage(
                            imageUrl: myProduct[1].imgUrl.toString(),
                            width: 140,
                            height: 140,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: 0,
                            isNetworkImage: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.sm),
                      Text(
                        myProduct[1].productName.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ):Container()
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            ///-------------------------------------------------------
            /// 전체보기 버튼
            ///-------------------------------------------------------
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => THelperFunctions.navigateToScreen(context, MemberAllGoodsScreen(myProduct: myProduct,)),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffF5F5F5),
                  padding: const EdgeInsets.all(TSizes.md),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: Text(
                  '전체보기',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      }
    }
  }
}
