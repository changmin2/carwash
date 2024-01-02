import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/component/comment_card.dart';
import 'package:carwash/community/provider/comment_provider.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/component/pagination_list_viewV2.dart';
import '../../common/component/rounded_container.dart';
import '../../common/component/rounded_image.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';

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
  Widget build(BuildContext context) {
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
                        // key: _contentKey,
                        child: TextFormField(
                          // onChanged: (value) {
                          //   content = value;
                          // },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "내용을 입력해주세요.";
                          //   }
                          // },
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
                      onTap: () {},
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

              Text('2023.12.21', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.grey)),
              const SizedBox(width: TSizes.sm),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 제목
              Text('오늘 세차 맛집 다녀왔어요~', style: Theme.of(context).textTheme.titleMedium),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 태그
              TRoundedContainer(
                padding: const EdgeInsets.all(TSizes.xs),
                showBorder: true,
                radius: 6,
                borderColor: PRIMARY_COLOR,
                child: Text(
                  '#세차장추천',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: PRIMARY_COLOR),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 글 내용
              Text(
                '오늘 세차 맛집 다녀왔어요~ 날씨도 춥고 연말이라 약속도 많아서 오랜만에 세차를 다녀왔는데 완전 맛집이였어요~ 센스있는 사장님께서 노래도 틀어놔 심심하지 않았어요. ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              SizedBox(
                height: 120,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: TSizes.spaceBtwItems / 2);
                  },
                  itemBuilder: (_, int index) {
                    return const TRoundedImage(
                      imageUrl: 'asset/img/car_image.jpeg',
                      width: 120,
                      height: 120,
                      fit: BoxFit.fill,
                      borderRadius: 12.0,
                    );
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections * 2),

              /// 추천 버튼 클릭시
              GestureDetector(
                onTap: (){},
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

                        Text('세차환자', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey)),
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
                          '10',
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


              /// 댓글 내용
              Text(
                '저도 시간 나면 한번 가봐야 겠네요~~',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// 댓글 아이디
              Row(
                children: [
                  Text(
                    '세차돌이',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  /// 댓글 아이디
                  Text(
                    '2023.01.02',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              
              const Divider(color: Colors.grey),
              
              const SizedBox(height: TSizes.spaceBtwItems),


              /// 대댓글 내용
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '┗',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '저도 시간 나면 한번 가봐야 겠네요~~',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// 댓글 아이디
                      Row(
                        children: [
                          Text(
                            '세차돌이',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          /// 댓글 아이디
                          Text(
                            '2023.01.02',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

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
