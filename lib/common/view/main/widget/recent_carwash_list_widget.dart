import 'package:flutter/material.dart';

import '../../../../car/view/carwash_record_screen.dart';
import '../../../component/recent_carwash_card.dart';
import '../../../const/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';


/// main_screen 에서 최근 세차 영억
class RecentCarWashListWidget extends StatelessWidget {
  const RecentCarWashListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '최근 세차',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () {
                THelperFunctions.navigateToScreen(context, const CarWashRecordScreen());
              },
              child: Text(
                'See all',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue),
              ),
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const Column(
          children: [
            RecentCarWashCard(),
            Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            RecentCarWashCard(),
            Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
            RecentCarWashCard(),
            Divider(
              color: Colors.grey,
              thickness: 0.3,
            ),
          ],
        ),
      ],
    );
  }
}
