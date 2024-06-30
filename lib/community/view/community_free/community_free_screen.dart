import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:carwash/community/view/community_free/widget/community_free_hot_card.dart';
import 'package:carwash/community/view/community_free/widget/community_free_list_widget.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';
import '../community_detail_screen.dart';

class TCommunityFreeScreen extends ConsumerWidget {
  const TCommunityFreeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hot = ref.watch(hotAllCommunityProvider);
    final hotLists = hot.map((element) => element.id);

    ref.watch(communityProvider);
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

                      hot.isNotEmpty
                          ?

                          /// HOT 전체 리스트
                          SizedBox(
                              height: 170,
                              child: ListView.builder(
                                itemCount: hot.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  var imgs = '';
                                  hot[index].imgUrls?.length != 0 ? imgs = hot[index].imgUrls!.split('[')[1].split(']')[0].split(",")[0] : null;

                                  return hot[index].category == "자유게시판"
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: TSizes.sm),
                                          child: TCommunityFreeHotCard(
                                            imageUrl: imgs == '' ? 'asset/img/no_image.png' : imgs,
                                            title: hot[index].title,
                                            model: hot[index],
                                            isNetworkImage: imgs == '' ? false : true,
                                          ),
                                        )
                                      : Container();
                                },
                              ),
                            )
                          : Container(),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      const Divider(thickness: 0.5),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      GestureDetector(
                        behavior: HitTestBehavior.translucent, //전체영역 클릭
                        onTap: () {
                          context.goNamed(CommunityDetailScreen.routeName, pathParameters: {'id': community.id.toString()});
                        },
                        child: TCommunityFreeListWidget(
                          hotYn: hotLists.contains(community.id) ? true : false,
                          hashtag: community.hastag,
                          date: community.createDate.split("T")[0],
                          title: community.title,
                          imageUrl: 'asset/img/profile_image.png',
                          nickName: community.creator,
                          likeCount: community.favorite,
                          replyCount: community.commentCnt,
                        ),
                      )
                    ],
                  );
                }

                return GestureDetector(
                  behavior: HitTestBehavior.translucent, //전체영역 클릭
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CommunityDetailScreen(
                          id: community.id,
                        )
                      ),
                    );
                  },
                  child: TCommunityFreeListWidget(
                    hotYn: hotLists.contains(community.id) ? true : false,
                    hashtag: community.hastag,
                    date: community.createDate.split("T")[0],
                    title: community.title,
                    imageUrl: 'asset/img/profile_image.png',
                    nickName: community.creator,
                    likeCount: community.favorite,
                    replyCount: community.commentCnt,
                  ),
                );
              },
            ),
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
                      const SizedBox(
                        height: 170,
                        child: SizedBox(
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      const Divider(thickness: 0.5),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      GestureDetector(
                        behavior: HitTestBehavior.translucent, //전체영역 클릭
                        onTap: () {
                          context.goNamed(CommunityDetailScreen.routeName, pathParameters: {'id': community.id.toString()});
                        },
                        child: TCommunityFreeListWidget(
                          hotYn: hotLists.contains(community.id) ? true : false,
                          hashtag: community.hastag,
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
                  behavior: HitTestBehavior.translucent, // 추가
                  onTap: () {
                    context.goNamed(CommunityDetailScreen.routeName, pathParameters: {'id': community.id.toString()});
                  },
                  child: TCommunityFreeListWidget(
                    hotYn: hotLists.contains(community.id) ? true : false,
                    hashtag: community.hastag,
                    date: community.createDate.split("T")[0],
                    title: community.title,
                    imageUrl: 'asset/img/car_image.jpeg',
                    nickName: community.creator,
                    likeCount: 10,
                    replyCount: 10,
                  ),
                );
              },
            ),
          );
  }
}
