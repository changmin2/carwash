import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/naver/model/search_model.dart';
import 'package:carwash/user/model/myProductDto.dart';
import 'package:carwash/user/provider/myProduct_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SearchProductDetailScreen extends ConsumerStatefulWidget {
  final Item item;
  const SearchProductDetailScreen({required this.item, Key? key}) : super(key: key);

  @override
  ConsumerState<SearchProductDetailScreen> createState() => _SearchProductDetailScreenState();
}

class _SearchProductDetailScreenState extends ConsumerState<SearchProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###,###,###,###');
    final state =ref.read(myProductProvider);
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ---------------------------------------------
                  /// 상품 이미지
                  /// ---------------------------------------------
                  TRoundedImage(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    height: MediaQuery.of(context).size.height/3,
                    imageUrl: widget.item.image,
                    isNetworkImage: true,
                    fit: BoxFit.fill,
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  Text(
                    widget.item.title.toString().replaceAll('<b>', '').replaceAll('</b>', ''),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems / 2),

                  Text(
                    '#${widget.item.category1} #${widget.item.category2} #${widget.item.category3} #${widget.item.category4}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '최저 ${f.format(int.parse(widget.item.lprice))}원',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TRoundedContainer(
              width: THelperFunctions.screenWidth(context),
              child: ElevatedButton(
                onPressed: () {
                  _showModalBottomSheet(
                      context,widget.item.title.toString().replaceAll('<b>', '').replaceAll('</b>', '')
                      ,widget.item.image
                      ,'#${widget.item.category1} #${widget.item.category2} #${widget.item.category3} #${widget.item.category4}'
                      ,widget.item.link
                  );
                },
                child: const Text('용품 추가하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context,String productName,String imgUrl,String category,String link) {
    final _nameFormKey = GlobalKey<FormState>();
    final _categoryFormKey = GlobalKey<FormState>();
    final _cycleFormKey = GlobalKey<FormState>();

    var _productName = productName;
    var _category = category;
    var _cycle = '';

    showModalBottomSheet(
      /// 바텀시트가 아닌 부분을 클릭했을 때
      /// 바텀시트를 닫을지 말지 설정
      isDismissible: true,

      /// false = 화면의 절반만 차지함
      /// true = 전체 화면 차이
      isScrollControlled: true,

      /// SafeArea 사용할지 말지 설정
      /// isScrollControlled을 true로 설정하면 상태바까지 올라감
      /// 이때 useSafeArea를 true로 설정하면 상태바는 사용 불가
      useSafeArea: true,

      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8 +MediaQuery.of(context).viewInsets.bottom/2,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('상품명'),
                      Text(
                        ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.sm),

                  /// 상품명
                  Form(
                    key: _nameFormKey,
                    child: TextFormField(
                      initialValue: productName,
                      decoration: const InputDecoration(
                        hintText: '상품명을 입력하세요.',
                      ),
                      onChanged: (String value) {
                        _productName = value;
                      },
                      validator: (value) {
                        if (value!.length < 1) {
                          return "상품명을 입력해주세요.";
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('카테고리'),
                      Text(
                        ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  const SizedBox(height: TSizes.sm),

                  /// 카테고리
                  Form(
                    key: _categoryFormKey,
                    child: TextFormField(
                      initialValue: category,
                      decoration: const InputDecoration(
                        hintText: '예) 카샴푸',
                      ),
                      onChanged: (String value) {
                        _category = value;
                      },
                      validator: (value) {
                        if (value!.length < 1) {
                          return "카테고리를 입력해주세요.";
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('사용주기'),
                    ],
                  ),

                  const SizedBox(height: TSizes.sm),

                  /// 사용주기
                  Form(
                    key: _cycleFormKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '예) 1개월, 매번',
                      ),
                      onChanged: (String value) {
                        _cycle = value;
                      },
                      validator: (value) {
                        if (value!.length < 1) {
                          return "사용주기를 입력해주세요.";
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  TRoundedContainer(
                    width: THelperFunctions.screenWidth(context),
                    child: OutlinedButton(
                      onPressed: () async {
                        if (_nameFormKey.currentState!.validate() &&
                            _categoryFormKey.currentState!.validate() &&
                            _cycleFormKey.currentState!.validate()){
                          await ref.read(myProductProvider.notifier).addProduct(
                            new MyProductDto(
                              productName: productName,
                              category:_category,
                              cycle: _cycle,
                              imgUrl: imgUrl,
                              link: link
                            )
                          );

                          context.pop();
                        }

                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: PRIMARY_COLOR),
                      ),
                      child: const Text('용품 추가 완료'),
                    )
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
