

import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/community/provider/button_provider.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../community/component/comment_card.dart';
import '../../community/model/community_model.dart';
import '../../community/provider/communityProvider.dart';
import '../../user/provider/favorite_provider.dart';
import '../../user/view/member_info/member_info_screen.dart';
import '../const/colors.dart';
import '../const/sizes.dart';
import '../model/cursor_pagination_model.dart';import '../model/model_with_idV2.dart';
import '../provider/comment_pagination_provider.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/pagination_utils.dart';
import 'image_viewer_screen.dart';

typedef PaginationWidgetBuilder<T extends IModelWithIdV2> =
Widget Function(BuildContext context, int index,T model);

class PaginationListViewV2<T extends IModelWithIdV2> extends ConsumerStatefulWidget {
  final StateNotifierProvider<CommentPaginationProvider,CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  final int id;
  final CommunityModel? model;
  //Detail화면인자 Recent화면인지 체크
  final bool? flag;

  const PaginationListViewV2({
    required this.provider,
    required this.itemBuilder,
    required this.id,
    this.model = null,
    this.flag = true,
    Key? key}) : super(key: key);

  @override
  ConsumerState<PaginationListViewV2> createState() => _PaginationListViewStateV2<T>();
}

class _PaginationListViewStateV2<T extends IModelWithIdV2> extends ConsumerState<PaginationListViewV2> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(listener);
  }

  void listener(){
    PaginationUtilsV2.paginate(
        controller: controller,
        provider: ref.read(widget.provider.notifier),
        id: widget.id
    );
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(communityProvider);
    final state = ref.watch(widget.provider);
    final button = ref.watch(buttonProvider);

    //좋아요 정보
    final favorites = ref.watch(favoriteProvider);
    var check = favorites.indexOf(widget.id);
    //완전 처음 로딩 일때

    if(state is CursorPaginationLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    //댓글이 아예 없거나 댓글을 단 후 삭제시 댓글이 0개가 되었을때
    if(state is CursorPaginationError || widget.model?.commentCnt == 0){
      List<String> imgs = [];
      if(widget.model!.imgUrls != ''){
        imgs = widget.model!.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
      }
      final favorites = ref.read(favoriteProvider);
      var check = favorites.indexOf(widget.id);
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 제목
            Text(widget.model!.title, style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// 닉네임
            GestureDetector(
              onTap: () => THelperFunctions.navigateToScreen(context, MemberInfoScreen(nickname: widget.model!.creator)),
              child: Row(
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
                        widget.model!.creator,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// 날짜, 좋아요
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.model!.createDate.split("T")[0],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
                GestureDetector(

                  onTap: button.disable==false ? () async {
                    //버튼 비활성화
                    button.change();
                    await ref.read(favoriteProvider.notifier).updateFavorites(widget.id);
                    await widget.flag == true
                        ?
                          await check == -1
                            ? ref.read(communityProvider.notifier).clickFavorite(widget.id)
                            : ref.read(communityProvider.notifier).downFavorite(widget.id)
                        :
                          await check == -1
                            ? ref.read(hotAllCommunityProvider.notifier).clickFavorite(widget.id)
                            : ref.read(hotAllCommunityProvider.notifier).downFavorite(widget.id);

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
                          widget.model!.favorite.toString(),
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
                          widget.model!.favorite.toString(),
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
            widget.model!.hastag != ''
                ? TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.xs),
              showBorder: true,
              radius: 6,
              borderColor: PRIMARY_COLOR,
              child: Text(
                '#${widget.model!.hastag!}',
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
              widget.model!.content.trim(),
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
                Text(widget.model!.commentCnt.toString(), style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

          ],
        )
      );
    }

    final cp = state as CursorPagination<T>;

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 0),
      child:  ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (_,index){
          if(index == cp.data.length){
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8
              ),
              child: Center(
                child: cp is CursorPaginationFetchingMore ?
                CircularProgressIndicator() :
                Text('댓글이 없습니다.'),
              ),
            );
          }

          final pItem = cp.data[index];

          //parsed변환
          return widget.itemBuilder(
            context,
            index,
            pItem,
          );
        },
        separatorBuilder: (_,index){
          return SizedBox(height: 16,);
        },
      ),
    );

  }
}
