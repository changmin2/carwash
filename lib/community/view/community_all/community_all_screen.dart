import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:carwash/community/provider/hot_free_community_provider.dart';
import 'package:carwash/community/view/community_all/widget/all_board_hot_card_widget.dart';
import 'package:carwash/community/view/community_all/widget/all_board_latest_post_widget.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/helpers/helper_functions.dart';
import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';
import '../community_recent_screen.dart';

class TCommunityAllScreen extends ConsumerWidget {
  const TCommunityAllScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hot = ref.watch(hotAllCommunityProvider);
    ref.watch(communityProvider);
    ref.watch(hotAllCommunityProvider);

    return Padding(
      padding: const EdgeInsets.all(TSizes.defalutSpace),
      child: PaginationListView(
          provider: communityProvider,
          itemBuilder: <CommunityModel>(_, index, community) {
            if (index == 0) {
              return Column(
                children: [
                  /// HOT 전체
                  /// HOT section header
                  const TCommunitySectionHeading(
                    firstTitle: 'HOT',
                    firstTitleColor: Colors.red,
                    secondTitle: '전체',
                    // showActionButton: true,
                    // buttonTitle: 'See All',
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  hot.length>0
                  ?
                  /// HOT 전체 리스트
                  SizedBox(
                    height: 270,
                    child: ListView.separated(
                      itemCount: hot.length >= 5 ? 5 : hot.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, __) {
                        return const SizedBox(width: TSizes.sm);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var imgs = '';
                        hot[index].imgUrls?.length != 0
                        ?
                            imgs = hot[index].imgUrls!.split('[')[1].split(']')[0].split(",")[0]
                        : null;

                        return GestureDetector(
                          onTap: () {
                            THelperFunctions.navigateToScreen(context, CommunityRecentScreen(model: hot[index],flag: 1,));
                          },
                          child: TCommunityAllHotCardWidget(
                            containerWidth: 200,
                            imageUrl: imgs == '' ? 'asset/img/no_image.png'
                            : imgs,
                            imageHeight: 200,
                            isNetworkImage: imgs == '' ? false : true,
                            nickName: hot[index].creator,
                            title: hot[index].content,
                            likeCount: hot[index].favorite.toString(),
                            commentCnt: hot[index].commentCnt.toString(),
                          ),
                        );
                      },
                    ),
                  )
                  :Container(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// 최신글
                  /// 최신글 section heading
                  const TCommunitySectionHeading(
                    firstTitle: '최신글',
                    secondTitle: '전체',
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  TCommunityAllLatestPostWidget(
                    model: community,
                  )
                ],
              );
            }
            return TCommunityAllLatestPostWidget(
              model: community,
            );
          }),
    );
  }
}
