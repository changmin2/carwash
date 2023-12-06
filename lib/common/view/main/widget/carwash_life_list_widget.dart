import 'package:flutter/material.dart';

import '../../../component/carwash_life_card.dart';
import '../../../const/sizes.dart';

class CarWashLifeListWidget extends StatelessWidget {
  const CarWashLifeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '세차 라이프',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue),
              ),
            )
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(padding: EdgeInsets.only(right: 8), child: CarWashLife());
            },
          ),
        ),
      ],
    );
  }
}
