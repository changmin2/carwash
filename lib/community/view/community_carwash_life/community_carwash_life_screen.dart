import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_carwash_life/widget/comunity_carwash_life_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';

class TCommunityCarWashLifeScreen extends ConsumerWidget {
  const TCommunityCarWashLifeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(communityProvider);

    return Padding(
      padding: const EdgeInsets.only(top: TSizes.defalutSpace),
      child: PaginationListView(
        provider: communityProvider,
        itemBuilder: <CommunityModel>(_, index, community) {
          return TCommunityCarWashLifeListWidget(
            model: community,
          );
        },
      ),
    );
  }
}
