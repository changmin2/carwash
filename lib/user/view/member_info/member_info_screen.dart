import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/user/view/member_info/widget/member_info_car_wash_goods_widget.dart';
import 'package:carwash/user/view/member_info/widget/member_info_car_wash_seq_widget.dart';
import 'package:flutter/material.dart';

class MemberInfoScreen extends StatelessWidget {
  const MemberInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///----------------------------------------------------------
          /// 유저정보
          ///----------------------------------------------------------
          TRoundedContainer(
            backgroundColor: PRIMARY_COLOR,
            radius: 0,
            padding: const EdgeInsets.all(TSizes.defalutSpace),
            child: Column(
              children: [
                Row(
                  children: [
                    /// 유저 사진
                    const TRoundedImage(
                      imageUrl: 'asset/img/profile_image.png',
                      borderRadius: 100,
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '주니아부지',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            '1단계 환자',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),

                    /// 팔로우 버튼
                    GestureDetector(
                      onTap: () => THelperFunctions.showAlert(context, '', '업데이트 예정입니다.'),
                      child: TRoundedContainer(
                        padding: const EdgeInsets.all(TSizes.md),
                        radius: 10,
                        // showBorder: true,
                        backgroundColor: Colors.indigoAccent,
                        child: Text(
                          '팔로우',
                          style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwItems),
                
                TRoundedContainer(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.all(TSizes.md),
                  showBorder: true,
                  borderColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '팔로워',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: TSizes.xs),
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '팔로잉',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: TSizes.xs),
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '게시물',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: TSizes.xs),
                          Text(
                            '0',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///----------------------------------------------------------
          /// 세차 용품, 세차 순서
          ///----------------------------------------------------------
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(TSizes.defalutSpace),
                child: Column(
                  children: [

                    ///----------------------------------------------------------
                    /// 세차 용품
                    ///----------------------------------------------------------
                    MemberInfoCarWashGoodsWidget(),

                    SizedBox(height: TSizes.spaceBtwSections),

                    Divider(thickness: 0.5),

                    SizedBox(height: TSizes.spaceBtwSections),

                    ///----------------------------------------------------------
                    /// 세차 순서
                    ///----------------------------------------------------------
                    MemberInfoCarWashSeqWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


