import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

import '../../car/model/recordDto.dart';

class RecentCarWashCard extends StatelessWidget {
  final recordDto record;
  const RecentCarWashCard({
    required this.record,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => THelperFunctions.navigateToScreen(context, const CarWashRecordScreen()),

      child: TRoundedContainer(
        height: 80,
        padding: const EdgeInsets.all(TSizes.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                
                /// 리스트 이미지
                Image.asset(
                  'asset/img/login.png',
                  width: 50,
                  height: 50,
                ),
                
                const SizedBox(width: TSizes.spaceBtwItems),
                
                /// 최근세차 정보
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.date.add(Duration(hours: 9)).toString().split(" ")[0],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      record.place,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
