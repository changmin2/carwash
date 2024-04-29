import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/const/sizes.dart';

/// -----------------------------------------------------
/// 나의 세차 용품 리스트에 나오는 카드 위젯
/// -----------------------------------------------------
class MyProductsEmptyListWidget extends StatelessWidget {
  const MyProductsEmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Iconsax.clipboard_close,
          size: 30,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          '등록한 세차 용품이 없습니다.',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}