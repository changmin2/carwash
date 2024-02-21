import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/provider/comment_provider.dart';
import 'package:carwash/community/provider/hot_free_community_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/component/pagination_list_viewV2.dart';
import '../../common/component/rounded_container.dart';
import '../../common/component/rounded_image.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/favorite_provider.dart';
import '../../user/provider/user_me_provider.dart';
import '../component/comment_card.dart';
import '../component/comment_register_screen.dart';
import '../model/community_model.dart';
import '../provider/communityProvider.dart';
import '../provider/hot_all_community_provider.dart';

class CommunityRecentScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityRecentScreen';
  final CommunityModel model;
  bool freeOrall;
  int flag;

  CommunityRecentScreen({
    required this.model,
    this.freeOrall = true,
    this.flag = 0,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CommunityRecentScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends ConsumerState<CommunityRecentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.invalidate(commentProvider);
    ref.watch(hotAllCommunityProvider);

    List<String> imgs = [];
    final favorites = ref.read(favoriteProvider);
    var check = favorites.indexOf(widget.model.id);
    if (widget.model.imgUrls != '') {
      imgs = widget.model.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
    }
    return DefaultLayoutV2(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()async{
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:  Text('신고되었습니다. 검토까지는 최대 24시간 소요되며 신고가 누적된 사용자는 글을 작성할 수 없게 됩니다.'),
                      duration: Duration(seconds: 1),
                    )
                );
              },
              child: Text(
                '신고'
              )
          )
        ],
      ),
      bottomNavagtionBar: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CommentRegisterScreen(id: widget.model.id, flag: widget.flag)));
        },
        child: TRoundedContainer(
          backgroundColor: const Color(0xffF8F8FA),
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          radius: 0,
          child: Text(
            '댓글을 남겨보세요.',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 700,
                child: Column(
                  children: [
                    Expanded(
                      child: PaginationListViewV2(
                          flag: false,
                          model: widget.model,
                          id: widget.model.id,
                          provider: commentProvider(widget.model.id),
                          itemBuilder: <Comment>(_, index, comment) {
                            if (index == 0) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// 날짜
                                  Text(
                                    widget.model.createDate.split("T")[0],
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey),
                                  ),

                                  const SizedBox(height: TSizes.spaceBtwItems),

                                  /// 제목
                                  Text(widget.model.title, style: Theme.of(context).textTheme.titleMedium),

                                  const SizedBox(height: TSizes.spaceBtwItems),

                                  /// 태그
                                  widget.model.hastag != ''
                                      ? TRoundedContainer(
                                          padding: const EdgeInsets.all(TSizes.xs),
                                          showBorder: true,
                                          radius: 6,
                                          borderColor: PRIMARY_COLOR,
                                          child: Text(
                                            widget.model.hastag!,
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: PRIMARY_COLOR),
                                          ),
                                        )
                                      : const SizedBox(),

                                  const SizedBox(height: TSizes.spaceBtwItems),

                                  /// 글 내용
                                  Text(
                                    widget.model.content,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                                  ),
                                  
                                  /// 등록 사진
                                  imgs.isNotEmpty
                                      ? Column(
                                          children: [
                                            const SizedBox(height: TSizes.spaceBtwSections),
                                            SizedBox(
                                              height: 120,
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemCount: imgs.length,
                                                separatorBuilder: (_, __) {
                                                  return const SizedBox(width: TSizes.spaceBtwItems / 2);
                                                },
                                                itemBuilder: (_, int index) {
                                                  return TRoundedImage(
                                                    imageUrl: imgs[index].toString().trim(),
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.fill,
                                                    borderRadius: 12.0,
                                                    isNetworkImage: true,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),

                                  const SizedBox(height: TSizes.spaceBtwSections * 2),

                                  /// 추천 버튼 클릭시
                                  GestureDetector(
                                    onTap: () {
                                      check == -1
                                          ? ref.read(hotAllCommunityProvider.notifier).clickFavorite(widget.model.id)
                                          : ref.read(hotAllCommunityProvider.notifier).downFavorite(widget.model.id);

                                      ref.read(favoriteProvider.notifier).updateFavorites(widget.model.id);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        /// 닉네임
                                        Row(
                                          children: [
                                            const TRoundedImage(
                                              width: 30,
                                              height: 30,
                                              fit: BoxFit.fill,
                                              imageUrl: 'asset/img/car_image.jpeg',
                                              borderRadius: 100,
                                            ),
                                            const SizedBox(width: TSizes.sm),
                                            Text(
                                              widget.model.creator,
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                                            ),
                                          ],
                                        ),

                                        /// 추천
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              check == -1 ? Iconsax.like_1 : Iconsax.like_11,
                                              size: 22,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: TSizes.xs),
                                            Text(
                                              widget.model.favorite.toString(),
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: TSizes.spaceBtwItems),

                                  Divider(thickness: 5, color: Colors.grey.withOpacity(0.3)),

                                  const SizedBox(height: TSizes.spaceBtwItems),

                                  /// 댓글 0이 아닐 경우
                                  Row(
                                    children: [
                                      Text('댓글', style: Theme.of(context).textTheme.bodySmall),
                                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                                      Text(widget.model.commentCnt.toString(), style: Theme.of(context).textTheme.bodySmall),
                                    ],
                                  ),

                                  const SizedBox(height: TSizes.spaceBtwItems),

                                  CommentCard(
                                    comment: comment,
                                    recomments: comment.commentList,
                                    board_id: widget.model.id,
                                    flag: widget.flag,
                                  )
                                ],
                              );
                            }
                            return CommentCard(
                              comment: comment,
                              recomments: comment.commentList,
                              board_id: widget.model.id,
                              flag: widget.flag,
                            );
                          }),
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),

              // Center(child: Text('첫 댓글을 남겨주세요.', style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
        ),
      ),
    );
  }
}
