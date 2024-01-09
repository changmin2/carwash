import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
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
import '../model/community_model.dart';
import '../provider/communityProvider.dart';

class CommunityRecentScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityRecentScreen';
  final CommunityModel model;
  const CommunityRecentScreen({
    required this.model,
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
    ref.watch(communityProvider.notifier);
    List<String> imgs = [];
    final _formKey = GlobalKey<FormState>();
    var _content;

    if(widget.model.imgUrls != ''){
      imgs = widget.model.imgUrls!.split("[")[1].split("]")[0].split(",").toList();
    }
    return DefaultLayoutV2(

      appBar: AppBar(
          // title: Text(state.title),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 8),
          //     child: _commentRegisterButton(context, ref, widget.id),
          //   ),
          // ],
          ),
      bottomNavagtionBar: GestureDetector(
        onTap: () {
          /// showModalBottomSheet().then((value){});     -> 바텀시트 닫은 경우 호출됨.
          /// showModalBottomSheet().whenComplete((){});  -> then 다음에 호출됨.
          showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            builder: (_) {
              return TRoundedContainer(
                height: THelperFunctions.screenHeight(context),
                padding: const EdgeInsets.all(TSizes.defalutSpace),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          onChanged: (value) {
                            _content = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "내용을 입력해주세요.";
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '댓글을 작성하세요.',
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        ),
                      ),
                    ),

                    const SizedBox(width: TSizes.spaceBtwItems),

                    /// 댓글 등록
                    GestureDetector(
                      onTap: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          final state = ref.watch(userMeProvider);
                          final pState = state as UserModel;

                          ref.watch(commentProvider(widget.model.id).notifier)
                              .createComment(pState.username, _content);
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Iconsax.edit,
                        size: 35,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
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

              Text(widget.model.createDate.split("T")[0], style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey)),
              const SizedBox(width: TSizes.sm),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 제목
              Text(widget.model.title, style: Theme.of(context).textTheme.titleMedium),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 태그
              widget.model.hastag != ''
              ?
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.xs),
                showBorder: true,
                radius: 6,
                borderColor: PRIMARY_COLOR,
                child: Text(
                  widget.model.hastag!,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: PRIMARY_COLOR),
                ),
              )
              :
              Container(),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 글 내용
              Text(
                widget.model.content,
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
                  ref.watch(communityProvider.notifier).clickFavorite(widget.model.id);
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

                        Text(widget.model.creator, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
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

              /// 댓글 0일 경우
              // Row(
              //   children: [
              //     Text('댓글', style: Theme.of(context).textTheme.bodySmall),
              //     const SizedBox(width: TSizes.spaceBtwItems / 2),
              //     Text('0', style: Theme.of(context).textTheme.bodySmall),
              //   ],
              // ),
              //
              // const SizedBox(height: TSizes.spaceBtwItems),
              //
              // Center(child: Text('첫 댓글을 남겨주세요.', style: Theme.of(context).textTheme.bodySmall)),

              /// 댓글 0이 아닐 경우
              Row(
                children: [
                  Text('댓글', style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Text('5', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                height: 700,
                child: Column(
                  children: [Expanded(
                    child: PaginationListViewV2(
                        id: widget.model.id,
                        provider: commentProvider(widget.model.id),
                        itemBuilder: <Comment>(_,index,comment){
                          return CommentCard(
                              comment:comment,
                              recomments:comment.commentList,
                              board_id: widget.model.id
                          );
                        }),
                  ),]
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

TextButton _commentRegisterButton(BuildContext context, WidgetRef ref, int id) {
  final _formKey = GlobalKey<FormState>();
  var _comment;

  return TextButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (value) {
                          _comment = value as String;
                        },
                        decoration: InputDecoration(border: OutlineInputBorder(), labelText: '댓글을 입력해주세요'),
                        validator: (value) {
                          if (value!.length < 1) {
                            return "댓글을 입력해주세요";
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              final state = ref.watch(userMeProvider);
                              final pState = state as UserModel;

                              ref.watch(commentProvider(id).notifier).createComment(pState.username, _comment);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('등록'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('취소'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                        )
                      ],
                    )
                  ],
                ),
              );
            });
      },
      child: Text(
        '댓글작성',
        style: TextStyle(fontSize: 18),
      ));
}
