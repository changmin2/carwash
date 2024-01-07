import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_carwash_life/widget/comunity_carwash_life_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';
import '../community_detail_screen_bak.dart';

class TCommunityCarWashLifeScreen extends StatelessWidget {
  const TCommunityCarWashLifeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children:[
            Expanded(
              child: PaginationListView(
                  provider: communityProvider,
                  itemBuilder: <CommunityModel>(_,index,community){
                    return GestureDetector(
                      onTap: (){
                        context.goNamed(CommunityDetailScreenBak.routeName,
                            pathParameters: {'id':community.id.toString()});
                      },
                      child: TCommunityCarWashLifeListWidget(
                        model: community,
                      ),
                    );
                  }),
            ),]
      ),
    );
  }
}

