import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/provider/hot_free_community_provider.dart';
import 'package:carwash/community/view/community_free/widget/community_free_hot_card.dart';
import 'package:carwash/community/view/community_free/widget/community_free_list_widget.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';
import '../community_detail_screen_bak.dart';

class TCommunityFreeScreen extends ConsumerWidget {
  const TCommunityFreeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hot = ref.watch(hotFreeCommunityProvider);
    return hot.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(TSizes.defalutSpace),
            child: PaginationListView(
                provider: communityProvider,
                itemBuilder: <CommunityModel>(_, index, community) {
                  if (index == 0) {
                    return Column(
                      children: [
                        /// HOT 자유게시판
                        /// HOT section header
                        const TCommunitySectionHeading(
                          firstTitle: 'HOT',
                          firstTitleColor: Colors.red,
                          secondTitle: '자유게시판',
                        ),

                        const SizedBox(height: TSizes.spaceBtwItems),

                        /// HOT 전체 리스트
                        SizedBox(
                          height: 170,
                          child: ListView.builder(
                            itemCount: hot.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return hot[index].category == "자유게시판"
                                  ? Padding(
                                      padding: EdgeInsets.only(right: TSizes.sm),
                                      child: TCommunityFreeHotCard(
                                        imageUrl: 'asset/img/car_image.jpeg',
                                        title: hot[index].title,
                                        model: hot[index],
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        ),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        const Divider(thickness: 1),

                        const SizedBox(height: TSizes.spaceBtwItems),

                        GestureDetector(
                          onTap: () {
                            context.goNamed(CommunityDetailScreenBak.routeName, pathParameters: {'id': community.id.toString()});
                          },
                          child: TCommunityFreeListWidget(
                            hotYn: true,
                            hashtag: '세차방법공유',
                            date: community.createDate.split("T")[0],
                            title: community.title,
                            imageUrl: 'asset/img/car_image.jpeg',
                            nickName: community.creator,
                            likeCount: 10,
                            replyCount: 10,
                          ),
                        )
                      ],
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      context.goNamed(CommunityDetailScreenBak.routeName, pathParameters: {'id': community.id.toString()});
                    },
                    child: TCommunityFreeListWidget(
                      hotYn: true,
                      hashtag: '세차방법공유',
                      date: community.createDate.split("T")[0],
                      title: community.title,
                      imageUrl: 'asset/img/car_image.jpeg',
                      nickName: community.creator,
                      likeCount: 10,
                      replyCount: 10,
                    ),
                  );
                }),
          )
        : Padding(
            padding: const EdgeInsets.all(TSizes.defalutSpace),
            child: PaginationListView(
                provider: communityProvider,
                itemBuilder: <CommunityModel>(_, index, community) {
                  if (index == 0) {
                    return Column(
                      children: [
                        /// HOT 자유게시판
                        /// HOT section header
                        const TCommunitySectionHeading(
                          firstTitle: 'HOT',
                          firstTitleColor: Colors.red,
                          secondTitle: '자유게시판',
                        ),

                        const SizedBox(height: TSizes.spaceBtwItems),

                        /// HOT 전체 리스트
                        SizedBox(height: 170, child: Container(height: 50, child: CircularProgressIndicator())),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        const Divider(thickness: 1),

                        const SizedBox(height: TSizes.spaceBtwItems),

                        GestureDetector(
                          onTap: () {
                            context.goNamed(CommunityDetailScreenBak.routeName, pathParameters: {'id': community.id.toString()});
                          },
                          child: TCommunityFreeListWidget(
                            hotYn: true,
                            hashtag: '세차방법공유',
                            date: community.createDate.split("T")[0],
                            title: community.title,
                            imageUrl: 'asset/img/car_image.jpeg',
                            nickName: community.creator,
                            likeCount: 10,
                            replyCount: 10,
                          ),
                        ),
                      ],
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      context.goNamed(CommunityDetailScreenBak.routeName, pathParameters: {'id': community.id.toString()});
                    },
                    child: TCommunityFreeListWidget(
                      hotYn: true,
                      hashtag: '세차방법공유',
                      date: community.createDate.split("T")[0],
                      title: community.title,
                      imageUrl: 'asset/img/car_image.jpeg',
                      nickName: community.creator,
                      likeCount: 10,
                      replyCount: 10,
                    ),
                  );
                }),
          );
  }
}
