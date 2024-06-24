import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../car/model/recordDto.dart';

class RecentCarWashCard extends StatelessWidget {
  final recordDto record;
  const RecentCarWashCard({required this.record, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 70,
      padding: const EdgeInsets.all(TSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Iconsax.broom,
                size: 30,
              ),

              const SizedBox(width: TSizes.spaceBtwItems),

              /// 최근세차 정보
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.date.add(const Duration(hours: 9)).toString().split(" ")[0],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    record.place,
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
            ],
          ),
          const Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}
