import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_all/widget/all_board_hot_card_widget.dart';
import 'package:carwash/community/view/community_all/widget/all_board_latest_post_widget.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            /// 요청사항 : 전체 게시판에서 핫한 글 5개만
            SizedBox(
              height: 270,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) {
                  return const SizedBox(width: TSizes.sm);
                },
                itemBuilder: (BuildContext context, int index) {
                  return const TCommunityAllHotCardWidget(
                    containerWidth: 200,
                    imageUrl: 'asset/img/car_image.jpeg',
                    imageHeight: 200,
                    nickName: '세린이',
                    title: '오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.',
                    likeCount: '120',
                  );
                },
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// 최신글
            /// 최신글 section heading
            const TCommunitySectionHeading(
              firstTitle: '최신글',
              secondTitle: '전체',
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// 최신글 리스트
            /// 요청사항 : 전체 게시판에서 최신 글 5개만
            ListView.separated(
              itemCount: 5,
              // 리스트에 해당되는 영역만 차지
              shrinkWrap: true,
              // 스크롤이 되지 않게.
              primary: false,
              separatorBuilder: (_, __) {
                return const Column(
                  children: [
                    SizedBox(height: TSizes.spaceBtwItems),
                    Divider(thickness: 0.5),
                    SizedBox(height: TSizes.spaceBtwItems),
                  ],
                );
              },
              itemBuilder: (_, int index) {
                String postType = "세차라이프";

                if (index == 0) {
                  postType = "세차라이프";
                } else if (index == 1) {
                  postType = "자유게시판";
                } else if (index == 2) {
                  postType = "질문게시판";
                } else {
                  postType = "세차라이프";
                }

                return GestureDetector(
                  child: Column(
                    children: [
                      TCommunityAllLatestPostWidget(
                        postType: postType,
                        title: '오늘 세차 맛집 다녀왔어요~',
                        nickName: '세린이',
                        imageUrl: 'asset/img/car_image.jpeg',
                      ),
                    ],
                  ),
                  onTap: () => context.goNamed(CommunityDetailScreen.routeName, pathParameters: {'id': '1'}),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
