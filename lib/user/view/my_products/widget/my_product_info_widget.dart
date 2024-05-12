import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/naver/view/search_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyProductInfoWidget extends StatelessWidget {
  var cnt = 0;
  MyProductInfoWidget({
    super.key,
    required this.cnt
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      backgroundColor: PRIMARY_COLOR,
      padding: const EdgeInsets.all(TSizes.defalutSpace),
      child: Column(
        children: [
          Row(
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
                cnt == 0
                ? '불러오는중....'
                :
                cnt.toString()+' 개',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2),

          const Divider(
            thickness: 1,
            color: Colors.white,
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2),

          GestureDetector(
            onTap: () => THelperFunctions.navigateToScreen(context, const SearchScreen()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Iconsax.add_square,
                  size: 24,
                  color: Colors.white,
                ),
                const SizedBox(width: TSizes.sm),
                Text(
                  '용품 추가하기',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}