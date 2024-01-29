import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:carwash/community/view/community_carwash_life/community_carwash_life_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../community/view/community_screen.dart';
import '../../../../community/provider/category_provider.dart';
import '../../../../community/provider/communityProvider.dart';
import '../../../../community/view/community_detail_screen.dart';
import '../../../component/carwash_life_card.dart';
import '../../../const/sizes.dart';

class CarWashLifeListWidget extends ConsumerStatefulWidget {
  const CarWashLifeListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<CarWashLifeListWidget> createState() => _CarWashLifeListWidgetState();
}

class _CarWashLifeListWidgetState extends ConsumerState<CarWashLifeListWidget> {

  @override
  Widget build(BuildContext context) {

    var community = ref.watch(hotAllCommunityProvider);

    return community.length == 0
    ? Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '세차 라이프',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () => THelperFunctions.navigateToScreen(context, const TCommunityCarWashLifeScreen()),
              child: Text(
                'See all',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue),
              ),
            )
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),
        CircularProgressIndicator(),
      ],
    )
    :
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '세차 라이프',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () => THelperFunctions.navigateToScreen(context, const CommunityScreen()),
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
          child: ListView.separated(
            itemCount: community.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return community[index].category == "세차라이프"
              ?
              Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: CarWashLife(model:community[index])
              )
              :
              Container();
            },
            separatorBuilder: (_, __) => const SizedBox(width: TSizes.spaceBtwItems),
            itemBuilder: (_, int index) => CarWashLife(model:community[index]),
          ),
        ),
      ],
    );
  }
}
