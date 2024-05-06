import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/component/recomment_card.dart';
import 'package:carwash/community/provider/button_provider.dart';
import 'package:carwash/community/provider/comment_provider.dart';
import 'package:carwash/community/provider/hot_free_community_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/component/image_viewer_screen.dart';
import '../../common/component/pagination_list_viewV2.dart';
import '../../common/component/rounded_container.dart';
import '../../common/component/rounded_image.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/block_provider.dart';
import '../../user/provider/favorite_provider.dart';
import '../../user/provider/user_me_provider.dart';
import '../component/comment_card.dart';
import '../component/comment_register_screen.dart';
import '../model/community_model.dart';
import '../provider/communityProvider.dart';
import '../provider/hot_all_community_provider.dart';
import 'community_screen.dart';

//HOT 커뮤니티 전용 상세 화면
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
    var gModel = ref.read(hotAllCommunityProvider.notifier).getModelById(widget.model.id);
    final button =ref.watch(buttonProvider);
    final user = ref.read(userMeProvider) as UserModel;
    List<String> imgs = [];
    final favorites = ref.watch(favoriteProvider);
    //현재 해당글이 좋아요 상태인지 아닌지 판단
    var check = favorites.indexOf(widget.model.id);
    // 좋아요 버튼 클릭시 비활성화

    if (widget.model.imgUrls != '') {
      imgs = widget.model.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
    }
    return DefaultLayoutV2(
      appBar: _renderAppbar(user, context),
      bottomNavagtionBar: _renderBottomNavagtionBar(context),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: PaginationListViewV2(
            flag: false,
            model: widget.model,
            id: widget.model.id,
            provider: commentProvider(widget.model.id),
            itemBuilder: <Comment>(_, index, comment) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 제목
                    Text(widget.model.title, style: Theme.of(context).textTheme.headlineMedium),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// 닉네임
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TRoundedImage(
                          width: 24,
                          height: 24,
                          fit: BoxFit.fill,
                          imageUrl: 'asset/img/no_image.png',
                          borderRadius: 100,
                        ),
                        const SizedBox(width: TSizes.sm),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.model.creator,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// 날짜, 좋아요
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.model.createDate.split("T")[0],
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                        ),
                        GestureDetector(

                          onTap: button.disable==false ? () async {
                            //버튼 비활성화
                            button.change();
                            await check == -1 ? ref.read(hotAllCommunityProvider.notifier).clickFavorite(widget.model.id) : ref.read(hotAllCommunityProvider.notifier).downFavorite(widget.model.id);
                            await ref.read(favoriteProvider.notifier).updateFavorites(widget.model.id);
                            //버튼 활성화
                            button.change();
                          } : null,
                          child: check == -1
                              ? TRoundedContainer(
                                  showBorder: true,
                                  padding: const EdgeInsets.all(TSizes.sm),
                                  borderColor: Colors.redAccent,
                                  radius: 10,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '좋아요',
                                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.redAccent),
                                      ),
                                      const SizedBox(width: TSizes.xs),
                                      Text(
                                        gModel!.favorite.toString(),
                                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.redAccent),
                                      ),
                                    ],
                                  ),
                                )
                              : TRoundedContainer(
                                  padding: const EdgeInsets.all(TSizes.sm),
                                  backgroundColor: Colors.redAccent,
                                  radius: 10,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '좋아요',
                                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(width: TSizes.xs),
                                      Text(
                                        gModel!.favorite.toString(),
                                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    const Divider(thickness: 0.5),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// 태그
                    widget.model.hastag != ''
                        ? TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.xs),
                            showBorder: true,
                            radius: 6,
                            borderColor: PRIMARY_COLOR,
                            child: Text(
                              '#${widget.model.hastag!}',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: PRIMARY_COLOR),
                            ),
                          )
                        : const SizedBox(),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// 등록 사진
                    imgs.isNotEmpty
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context)
                                  => ImageViewerScreen(imgUrl: imgs)
                                  ));
                                },
                                child: SizedBox(
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
                              ),
                            ],
                          )
                        : const SizedBox(),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    /// 글 내용
                    Text(
                      widget.model.content.trim(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                    ),

                    const SizedBox(height: TSizes.spaceBtwSections),

                    const Divider(thickness: 0.5),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// 댓글 0이 아닐 경우
                    Row(
                      children: [
                        Text('댓글', style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),
                        Text(gModel.commentCnt.toString(), style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    CommentCard(
                      comment: comment,
                      recomments: comment.commentList,
                      board_id: widget.model.id,
                      flag: widget.flag,
                    ),
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
    );
  }

  GestureDetector _renderBottomNavagtionBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        THelperFunctions.navigateToScreen(context, CommentRegisterScreen(id: widget.model.id, flag: widget.flag));
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
    );
  }

  AppBar _renderAppbar(UserModel user, BuildContext context) {
    return AppBar(
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 16),
            child: PopupMenuButton(
              child: const Icon(
                Icons.menu,
                size: 30,
              ),
              itemBuilder: (BuildContext context) => (user.nickname == '관리자' || widget.model.creator == user.nickname)
                  ? [PopupMenuItem(value: 2, child: Text("신고")), PopupMenuItem(value: 3, child: Text("삭제"))]
                  : [PopupMenuItem(value: 1, child: Text("차단")), PopupMenuItem(value: 2, child: Text("신고"))],
              onSelected: (dynamic select) async {
                if (select == 1) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[new Text("유저 차단")],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[Text("차단한 유저의 게시글은 숨김 처리 됩니다.")],
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('취소')),
                            TextButton(
                                onPressed: () async {
                                  await ref.read(blockProvider.notifier).addBlock(widget.model.creator);
                                  ref.read(hotAllCommunityProvider.notifier).getHotAll();
                                  ref.read(communityProvider.notifier).paginate(forceRefetch: true);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('확인'))
                          ],
                        );
                      });
                } else if (select == 2) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('신고되었습니다. 검토까지는 최대 24시간 소요되며 신고가 누적된 사용자는 글을 작성할 수 없게 됩니다.'),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[new Text("글 삭제")],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[Text("정말 삭제하시겠습니까?")],
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('취소')),
                            TextButton(
                                onPressed: () async {
                                  await ref.read(communityProvider.notifier).deleteBoard(widget.model.id);
                                  ref.read(hotAllCommunityProvider.notifier).getHotAll();
                                  ref.read(communityProvider.notifier).paginate(forceRefetch: true);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('확인'))
                          ],
                        );
                      });
                }
              },
            ))
      ],
    );
  }
}
