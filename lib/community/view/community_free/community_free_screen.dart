import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_free/widget/community_free_hot_card.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';
import '../community_all/widget/all_board_latest_post_widget.dart';
import '../community_detail_screen_bak.dart';

class TCommunityFreeScreen extends StatelessWidget {
  const TCommunityFreeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [
            Container(
              height: 500,
              child: Column(
                children: [
                  Expanded(
                    child: PaginationListView(
                        provider: communityProvider,
                        itemBuilder: <CommunityModel>(_,index,community){
                          if(index == 0){
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
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return const Padding(
                                        padding: EdgeInsets.only(right: TSizes.sm),
                                        child: TCommunityFreeHotCard(
                                          imageUrl: 'asset/img/car_image.jpeg',
                                          title: '오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.',
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: TSizes.spaceBtwSections),

                                const Divider(thickness: 1),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                GestureDetector(
                                onTap: (){
                                  context.goNamed(CommunityDetailScreenBak.routeName,
                                  pathParameters: {'id':community.id.toString()});
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        TRoundedContainer(
                                        padding: const EdgeInsets.all(TSizes.xs),
                                        showBorder: true,
                                        radius: 6,
                                        borderColor: Colors.redAccent,
                                        child: Text(
                                            'HOT',
                                            style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.redAccent),
                                          ),
                                        ),
                                const SizedBox(width: TSizes.sm),
                                TRoundedContainer(
                                  padding: const EdgeInsets.all(TSizes.xs),
                                  showBorder: true,
                                  radius: 6,
                                  child: Text(
                                    '#세차방법공유',
                                    style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey),
                                  ),
                                ),
                                const SizedBox(width: TSizes.sm),
                                Text(community.createDate.split("T")[0], style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
                                ],
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),

                                Text(community.title, style: Theme.of(context).textTheme.bodyMedium,),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const TRoundedImage(
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                    imageUrl: 'asset/img/car_image.jpeg',
                                    borderRadius: 100,
                                ),

                                const SizedBox(width: TSizes.sm),

                                Text(community.creator, style: Theme.of(context).textTheme.bodySmall),
                                const SizedBox(width: TSizes.sm),
                                Text('|', style: Theme.of(context).textTheme.bodySmall),
                                const SizedBox(width: TSizes.sm),

                                const Icon(
                                  Iconsax.like_1,
                                  size: 14,
                                ),
                                // Text(
                                //   '추천',
                                //   style: Theme.of(context).textTheme.bodySmall,
                                // ),
                                const SizedBox(width: TSizes.xs),
                                Text(
                                  '10',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(width: TSizes.sm),
                                Text('|', style: Theme.of(context).textTheme.bodySmall),
                                const SizedBox(width: TSizes.sm),
                                const Icon(
                                  Iconsax.message4,
                                  size: 14,
                                ),

                                // Text(
                                //   '댓글',
                                //   style: Theme.of(context).textTheme.bodySmall,
                                // ),
                                const SizedBox(width: TSizes.xs),
                                Text(
                                  '10',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                ],
                                ),
                                SizedBox(height: TSizes.spaceBtwItems),
                                Divider(thickness: 1),
                                SizedBox(height: TSizes.spaceBtwItems)
                                ],
                                ),
                                )
                              ],
                            );
                          }
                          return GestureDetector(
                            onTap: (){
                              context.goNamed(CommunityDetailScreenBak.routeName,
                                  pathParameters: {'id':community.id.toString()});
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TRoundedContainer(
                                      padding: const EdgeInsets.all(TSizes.xs),
                                      showBorder: true,
                                      radius: 6,
                                      borderColor: Colors.redAccent,
                                      child: Text(
                                        'HOT',
                                        style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.redAccent),
                                      ),
                                    ),
                                    const SizedBox(width: TSizes.sm),
                                    TRoundedContainer(
                                      padding: const EdgeInsets.all(TSizes.xs),
                                      showBorder: true,
                                      radius: 6,
                                      child: Text(
                                        '#세차방법공유',
                                        style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(width: TSizes.sm),
                                    Text(community.createDate.split("T")[0], style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.grey)),
                                  ],
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),

                                Text(community.title, style: Theme.of(context).textTheme.bodyMedium,),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const TRoundedImage(
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.fill,
                                      imageUrl: 'asset/img/car_image.jpeg',
                                      borderRadius: 100,
                                    ),

                                    const SizedBox(width: TSizes.sm),

                                    Text(community.creator, style: Theme.of(context).textTheme.bodySmall),
                                    const SizedBox(width: TSizes.sm),
                                    Text('|', style: Theme.of(context).textTheme.bodySmall),
                                    const SizedBox(width: TSizes.sm),

                                    const Icon(
                                      Iconsax.like_1,
                                      size: 14,
                                    ),
                                    // Text(
                                    //   '추천',
                                    //   style: Theme.of(context).textTheme.bodySmall,
                                    // ),
                                    const SizedBox(width: TSizes.xs),
                                    Text(
                                      '10',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(width: TSizes.sm),
                                    Text('|', style: Theme.of(context).textTheme.bodySmall),
                                    const SizedBox(width: TSizes.sm),
                                    const Icon(
                                      Iconsax.message4,
                                      size: 14,
                                    ),

                                    // Text(
                                    //   '댓글',
                                    //   style: Theme.of(context).textTheme.bodySmall,
                                    // ),
                                    const SizedBox(width: TSizes.xs),
                                    Text(
                                      '10',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                SizedBox(height: TSizes.spaceBtwItems),
                                Divider(thickness: 1),
                                SizedBox(height: TSizes.spaceBtwItems)
                              ],
                            ),
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
