import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/user/model/myProductDto.dart';
import 'package:carwash/user/view/my_products/widget/my_products_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

///-------------------------------------------------
///-------------------------------------------------
/// 다른 회원 용품 전체보기 화면
///-------------------------------------------------
///-------------------------------------------------
class MemberAllGoodsScreen extends StatelessWidget {
  final List<MyProductDto> myProduct;
  MemberAllGoodsScreen({
    required this.myProduct,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [
            ///-------------------------------------------------
            /// 다른 회원 용품 정보
            ///-------------------------------------------------
            TRoundedContainer(
              backgroundColor: PRIMARY_COLOR,
              padding: const EdgeInsets.all(TSizes.defalutSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Iconsax.d_cube_scan,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(width: TSizes.sm),
                      Text(
                        '등록한 용품',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    myProduct.length.toString() +' 개',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// ---------------------------------------------
            /// 세차 용품 리스트
            /// ---------------------------------------------
            Expanded(
              child: ListView.separated(
                  itemCount: myProduct.length,
                  separatorBuilder: (_, __) => const Column(
                    children: [
                      SizedBox(height: TSizes.spaceBtwItems),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  ),
                  itemBuilder: (_, index) {
                    return MyProductsListWidget(item: myProduct[index],);
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}
