

import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../community/model/community_model.dart';
import '../../community/provider/communityProvider.dart';
import '../const/colors.dart';
import '../const/sizes.dart';
import '../model/cursor_pagination_model.dart';import '../model/model_with_idV2.dart';
import '../provider/comment_pagination_provider.dart';
import '../utils/pagination_utils.dart';

typedef PaginationWidgetBuilder<T extends IModelWithIdV2> =
Widget Function(BuildContext context, int index,T model);

class PaginationListViewV2<T extends IModelWithIdV2> extends ConsumerStatefulWidget {
  final StateNotifierProvider<CommentPaginationProvider,CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> itemBuilder;
  final int id;
  final CommunityModel? model;

  const PaginationListViewV2({
    required this.provider,
    required this.itemBuilder,
    required this.id,
    this.model = null,
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
    //완전 처음 로딩 일때
    if(state is CursorPaginationLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(state is CursorPaginationError){
      var imgs = [];
      if(widget.model!.imgUrls != ''){
        imgs = widget.model!.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.model!.createDate.split("T")[0], style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey)),
          const SizedBox(width: TSizes.sm),

          const SizedBox(height: TSizes.spaceBtwItems),

          /// 제목
          Text(widget.model!.title, style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: TSizes.spaceBtwItems),

          /// 태그
          widget.model!.hastag != ''
              ?
          TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.xs),
            showBorder: true,
            radius: 6,
            borderColor: PRIMARY_COLOR,
            child: Text(
              widget.model!.hastag!,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: PRIMARY_COLOR),
            ),
          )
              :
          Container(),

          const SizedBox(height: TSizes.spaceBtwItems),

          /// 글 내용
          Text(
            widget.model!.content,
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

                    Text(widget.model!.creator, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
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
                      widget.model!.favorite.toString(),
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
              Text(widget.model!.commentCnt.toString(), style: Theme.of(context).textTheme.bodySmall),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

        ],
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
