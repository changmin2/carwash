import 'package:carwash/car/provider/myrecord_provider.dart';
import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/common/view/dilution/dilution_screen.dart';
import 'package:carwash/community/view/community_screen.dart';
import 'package:carwash/naver/model/search_model.dart';
import 'package:carwash/naver/repository/search_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../car/view/register_first_screen.dart';
import '../../../../community/provider/category_provider.dart';

class TopMenuWidget extends ConsumerWidget {
  const TopMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
        /// 세차기록
        GestureDetector(
          onTap: () async {
            //네이버쇼핑 테스트
            //SearchModel res = await ref.read(searchRepositoryProvider).searchProduct(item: "세차용품");
            context.goNamed(RecordFirstScreen.routeName);
          },
          child: TRoundedContainer(
            width: 100,
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                const Icon(
                  Icons.airport_shuttle,
                  color: Colors.deepOrangeAccent,
                ),
                const SizedBox(height: TSizes.sm),
                Text(
                  '세차기록',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
        ),

        /// 커뮤니티
        GestureDetector(
          onTap: () async {
            //카테고리 초기화
            await ref.read(categoryProvider.notifier).update((state) => '');
            context.goNamed(CommunityScreen.routeName);
          } ,
          child: TRoundedContainer(
            width: 100,
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                const Icon(
                  Icons.family_restroom_outlined,
                  color: Colors.deepOrangeAccent,
                ),
                const SizedBox(height: TSizes.sm),
                Text(
                  '커뮤니티',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
        ),

        /// 희석비율
        GestureDetector(
          onTap: () => THelperFunctions.navigateToScreen(context, const DilutionScreen()),
          child: TRoundedContainer(
            width: 100,
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                const Icon(
                  Icons.science,
                  color: Colors.deepOrangeAccent,
                ),
                const SizedBox(height: TSizes.sm),
                Text(
                  '희석비율',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          ),
        ),


      ],
    );
  }
}
