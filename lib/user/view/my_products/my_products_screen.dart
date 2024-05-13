import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/user/provider/myProduct_provider.dart';
import 'package:carwash/user/view/my_products/widget/my_product_info_widget.dart';
import 'package:carwash/user/view/my_products/widget/my_products_empty_list_widget.dart';
import 'package:carwash/user/view/my_products/widget/my_products_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class MyProductsScreen extends ConsumerStatefulWidget {
  const MyProductsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends ConsumerState<MyProductsScreen> {

  @override
  Widget build(BuildContext context) {
    final myProducts = ref.watch(myProductProvider);

    return DefaultLayoutV2(

      appBar: AppBar(),
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [

            /// ---------------------------------------------
            /// 등록한 세차 용품 정보
            /// ---------------------------------------------
            myProducts == null
            ?
            MyProductInfoWidget(cnt: 0)
            :
            MyProductInfoWidget(cnt: myProducts.length),


            const SizedBox(height: TSizes.spaceBtwSections),


            /// ---------------------------------------------
            /// 세차 용품 리스트
            /// ---------------------------------------------
            myProducts.length == 0
                ? const MyProductsEmptyListWidget()
                : Expanded(
                  child: ListView.separated(
                      itemCount: myProducts.length,
                      separatorBuilder: (_, __) => const Column(
                        children: [
                          SizedBox(height: TSizes.spaceBtwItems),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                        ],
                      ),
                      itemBuilder: (_, int index) {
                        return MyProductsListWidget(
                          item: myProducts[index],
                        );
                      }
                    ),
                ),
          ],
        ),
      ),
    );
  }
}
