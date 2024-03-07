import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/component/comment_register_screen.dart';
import 'package:carwash/community/provider/comment_provider.dart';
import 'package:carwash/user/model/user_model.dart';
import 'package:carwash/user/provider/block_provider.dart';
import 'package:carwash/user/provider/favorite_provider.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/component/pagination_list_viewV2.dart';
import '../../common/component/rounded_container.dart';
import '../../common/component/rounded_image.dart';
import '../component/comment_card.dart';
import '../provider/communityProvider.dart';
import '../provider/hot_all_community_provider.dart';
import 'community_screen.dart';

class CommunityDetailScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityDetailScreen';
  final id;
  const CommunityDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends ConsumerState<CommunityDetailScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ref.invalidate(commentProvider);
    ref.watch(communityProvider);
    final state = ref.read(communityProvider.notifier).getDetail(widget.id);
    final favorites = ref.read(favoriteProvider);
    final user = ref.read(userMeProvider) as UserModel;
    var check = favorites.indexOf(widget.id);
    List<String> imgs = [];

    if(state.imgUrls != ''){
      imgs = state.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
    }
    return DefaultLayoutV2(
      appBar: AppBar(
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: PopupMenuButton(
                child: Icon(
                  Icons.menu,
                  size: 30,
                ),
                itemBuilder: (BuildContext context) =>
                (user.nickname == '관리자' || state.creator == user.nickname)
                ?
                [
                  PopupMenuItem(value:2 ,child: Text("신고")),
                  PopupMenuItem(value:3 ,child: Text("삭제"))
                ]
                    :
                [
                  PopupMenuItem(value: 1, child: Text("차단")),
                  PopupMenuItem(value:2 ,child: Text("신고"))
                ],
                onSelected: (dynamic select) async {
                  if(select == 1){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text("유저 차단")
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                    "차단한 유저의 게시글은 숨김 처리 됩니다."
                                )
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                      '취소'
                                  )
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await ref.read(blockProvider.notifier).addBlock(state.creator);
                                    ref.read(hotAllCommunityProvider.notifier).getHotAll();
                                    ref.read(communityProvider.notifier).paginate(forceRefetch: true);
                                    context.goNamed(CommunityScreen.routeName);
                                  },
                                  child: Text(
                                      '확인'
                                  )
                              )
                            ],
                          );
                        }
                    );
                  }
                  else if(select == 2){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:  Text('신고되었습니다. 검토까지는 최대 24시간 소요되며 신고가 누적된 사용자는 글을 작성할 수 없게 됩니다.'),
                          duration: Duration(seconds: 1),
                        )
                    );
                  }else{
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text("글 삭제")
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                    "정말 삭제하시겠습니까?"
                                )
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                      '취소'
                                  )
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await ref.read(communityProvider.notifier).deleteBoard(widget.id);
                                    ref.read(hotAllCommunityProvider.notifier).getHotAll();
                                    ref.read(communityProvider.notifier).paginate(forceRefetch: true);
                                    context.goNamed(CommunityScreen.routeName);
                                  },
                                  child: Text(
                                      '확인'
                                  )
                              )
                            ],
                          );
                        }
                    );
                  }
                },
              )
          )
        ],
      ),
      bottomNavagtionBar:
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CommentRegisterScreen( id: widget.id)));
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
            children: [
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                    child: PaginationListViewV2(
                        model: state,
                        id: widget.id,
                        provider: commentProvider(widget.id),
                        itemBuilder: <Comment>(_,index,comment){
                          if(index == 0){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(state.createDate.split("T")[0], style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey)),
                                const SizedBox(width: TSizes.sm),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                /// 제목
                                Text(state.title, style: Theme.of(context).textTheme.titleMedium),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                /// 태그
                                state.hastag != ''
                                    ?
                                TRoundedContainer(
                                  padding: const EdgeInsets.all(TSizes.xs),
                                  showBorder: true,
                                  radius: 6,
                                  borderColor: PRIMARY_COLOR,
                                  child: Text(
                                    state.hastag!,
                                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: PRIMARY_COLOR),
                                  ),
                                )
                                    :
                                Container(),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                /// 글 내용
                                Text(
                                  state.content,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                                ),

                                const SizedBox(height: TSizes.spaceBtwSections),
                                imgs.length > 0
                                    ?
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
                                )
                                    :
                                Container(),
                                const SizedBox(height: TSizes.spaceBtwSections * 2),

                                /// 추천 버튼 클릭시
                                GestureDetector(
                                  onTap: () {
                                    ref.read(favoriteProvider.notifier).updateFavorites(widget.id);
                                    check == -1
                                    ? ref.read(communityProvider.notifier).clickFavorite(widget.id)
                                    : ref.read(communityProvider.notifier).downFavorite(widget.id);


                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const TRoundedImage(
                                            width: 30,
                                            height: 30,
                                            fit: BoxFit.fill,
                                            imageUrl: 'asset/img/profile_image.png',
                                            borderRadius: 100,
                                          ),

                                          const SizedBox(width: TSizes.sm),

                                          Container(
                                              width: MediaQuery.of(context).size.width*0.55,
                                              child: Text(
                                                  state.creator,
                                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                      color: Colors.grey,
                                                      overflow: TextOverflow.ellipsis
                                                  )
                                              )
                                          ),
                                        ],
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            check == -1
                                            ? Iconsax.like_1
                                            : Iconsax.like_11,
                                            size: 22,
                                            color: Colors.grey,

                                          ),
                                          const SizedBox(width: TSizes.xs),
                                          Text(
                                            state.favorite.toString(),
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
                                    Text(state.commentCnt.toString(), style: Theme.of(context).textTheme.bodySmall),
                                  ],
                                ),

                                const SizedBox(height: TSizes.spaceBtwItems),

                                CommentCard(
                                    comment:comment,
                                    recomments:comment.commentList,
                                    board_id: widget.id
                                )

                              ],
                            );
                          }
                          return CommentCard(
                              comment:comment,
                              recomments:comment.commentList,
                              board_id: widget.id
                          );
                        }),
                  ),
                  Container(
                    height: 100
                  )
                  ]
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
