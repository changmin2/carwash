import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_carwash_life/widget/comunity_carwash_life_list_widget.dart';
import 'package:flutter/material.dart';

class TCommunityCarWashLifeScreen extends StatelessWidget {
  const TCommunityCarWashLifeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: TSizes.defalutSpace),
        separatorBuilder: (_, int index) {
          return const SizedBox(height: TSizes.spaceBtwSections);
        },
        itemBuilder: (_, int index) {
          return TCommunityCarWashLifeListWidget();
        });
  }
}

