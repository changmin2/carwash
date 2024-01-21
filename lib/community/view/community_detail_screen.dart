import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/model/cursor_pagination_model.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/component/comment_register_screen.dart';
import 'package:carwash/community/provider/comment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../common/component/pagination_list_viewV2.dart';
import '../../common/component/rounded_container.dart';
import '../../common/component/rounded_image.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../component/comment_card.dart';
import '../provider/communityProvider.dart';

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
  var st;
  Future<void> commentFuture() async{
    st = await ref.read(commentProvider(widget.id));
  }
  @override
  Widget build(BuildContext context) {
    ref.invalidate(commentProvider);
    ref.watch(communityProvider);
    final state = ref.read(communityProvider.notifier).getDetail(widget.id);
    List<String> imgs = [];


    if(state.imgUrls != ''){
      imgs = state.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
    }
    return DefaultLayoutV2(
      appBar: AppBar(),
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
                height: 700,
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
                                        imageUrl: imgs[index],
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
                                  onTap: (){
                                    ref.read(communityProvider.notifier).clickFavorite(widget.id);
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
                                            imageUrl: 'asset/img/car_image.jpeg',
                                            borderRadius: 100,
                                          ),

                                          const SizedBox(width: TSizes.sm),

                                          Text(state.creator, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
                                        ],
                                      ),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            Iconsax.like_1,
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
                    height: 100,
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
