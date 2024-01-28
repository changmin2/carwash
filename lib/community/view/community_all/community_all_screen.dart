import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:carwash/community/view/community_all/widget/all_board_hot_card_widget.dart';
import 'package:carwash/community/view/community_all/widget/all_board_latest_post_widget.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../component/community_card.dart';
import '../../provider/communityProvider.dart';
import '../community_detail_screen.dart';
import '../community_recent_screen.dart';

class TCommunityAllScreen extends ConsumerWidget {
  const TCommunityAllScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final hot = ref.watch(hotAllCommunityProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [
            Container(
              height: 500,
              child: Column(
                children:[
                  Expanded(
                  child: PaginationListView(
                      provider: communityProvider,
                      itemBuilder: <CommunityModel>(_,index,community){
                        if(index == 0){
                          return Column(children: [
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

                            /// HOT 전체 리스트
                            SizedBox(
                              height: 270,
                              child: ListView.builder(
                                itemCount: hot.length >= 5? 5 : hot.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: TSizes.sm),
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityRecentScreen(model: hot[index],flag: 1,)));
                                      },
                                      child: TCommunityAllHotCardWidget(
                                        containerWidth: 200,
                                        imageUrl: 'asset/img/car_image.jpeg',
                                        imageHeight: 200,
                                        nickName: hot[index].creator,
                                        title: hot[index].content,
                                        likeCount: hot[index].favorite.toString(),
                                        commentCnt:hot[index].commentCnt.toString()
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: TSizes.spaceBtwItems),


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
                ),]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
