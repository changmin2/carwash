import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../common/component/rounded_container.dart';
import '../../../../common/component/rounded_image.dart';
import '../../../../common/const/sizes.dart';
import '../../../../common/utils/helpers/helper_functions.dart';
import '../../../provider/category_provider.dart';
import '../../../provider/hot_all_community_provider.dart';
import '../../community_detail_screen.dart';
import '../../community_recent_screen.dart';

class TCommunityRecentQuestionListWidget extends ConsumerStatefulWidget {

  final Function tabController;
  TCommunityRecentQuestionListWidget({
    required this.tabController,
    super.key
  });

  @override
  ConsumerState<TCommunityRecentQuestionListWidget> createState() => _TCommunityRecentQuestionListWidgetState();
}

class _TCommunityRecentQuestionListWidgetState extends ConsumerState<TCommunityRecentQuestionListWidget> {


  @override
  Widget build(BuildContext context) {
    var community = ref.watch(hotAllCommunityProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '세차 궁금해요',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: TSizes.xs),
                Text(
                  '세차에 대해 질문하고 답해봐요',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                await ref.read(categoryProvider.notifier).update((state) => "질문게시판");
                widget.tabController(
                    2,3
                );
              },
              child: Row(
                children: [
                  Text(
                    '더보기',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// ----------------------------------------------------------------
        /// 세차 질문 리스트
        /// ----------------------------------------------------------------
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: community.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            //separatorBuilder: (_, __) => const SizedBox(height: TSizes.md),
            itemBuilder: (BuildContext context, int index) {
              return community[index].category == "질문게시판"
              ?
              GestureDetector(
                onTap: (){
                  THelperFunctions.navigateToScreen(
                    context,
                    CommunityRecentScreen(
                      model: community[index],
                      flag: 1,
                    ),
                  );
                },
                child: Column(
                  children: [
                    TRoundedContainer(
                      padding: const EdgeInsets.all(TSizes.md),
                      // height: 80,
                      showBorder: true,
                      borderColor: const Color(0xffDADADA),
                      radius: 10.0,
                      child: Row(
                        children: [
                          const Icon(Iconsax.message_question),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  community[index].title,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: TSizes.xs),
                                Text(

                                  '좋아요 '+community[index].favorite.toString()+' · 댓글 '+community[index].commentCnt.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: const Color(0xff9E9E9E)),
                                ),
                              ],
                            ),
                          ),
                          community[index].imgUrls != ""
                          ?
                          TRoundedImage(
                            isNetworkImage: true,
                            imageUrl: community[index].imgUrls.toString().split(",")[0].split("[")[1].split("]")[0],
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                            borderRadius: 0,
                          )
                          :
                          Container()
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.md)
                  ]
                ),
              )
              : Container();
            },
          ),
        )
      ],
    );
  }
}