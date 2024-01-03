import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_all/widget/all_board_hot_card_widget.dart';
import 'package:carwash/community/view/community_all/widget/all_board_latest_post_widget.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../component/community_card.dart';
import '../../provider/communityProvider.dart';
import '../community_detail_screen.dart';

class TCommunityAllScreen extends StatelessWidget {
  const TCommunityAllScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
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

            /// HOT 전체 리스트
            SizedBox(
              height: 270,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(right: TSizes.sm),
                    child: TCommunityAllHotCardWidget(
                      containerWidth: 200,
                      imageUrl: 'asset/img/car_image.jpeg',
                      imageHeight: 200,
                      nickName: '세린이',
                      title: '오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.',
                      likeCount: '120',
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // SizedBox(
            //   width: double.infinity,
            //   child: OutlinedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xffE6EAEE),
            //     ),
            //     child: Text(
            //       "전체보기",
            //       style: Theme.of(context).textTheme.titleMedium
            //     ),
            //   ),
            // ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// 최신글
            /// 최신글 section heading
            const TCommunitySectionHeading(
              firstTitle: '최신글',
              secondTitle: '전체',
            ),

            const SizedBox(height: TSizes.spaceBtwItems),
            Container(
              height: 500,
              child: Column(
                children:[
                  Expanded(
                  child: PaginationListView(
                      provider: communityProvider,
                      itemBuilder: <CommunityModel>(_,index,community){
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
