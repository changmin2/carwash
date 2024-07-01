import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/provider/category_provider.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:carwash/community/view/community_carwash_life/community_carwash_life_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../community/view/community_screen.dart';
import '../../../component/carwash_life_card.dart';
import '../../../const/sizes.dart';

class CarWashLifeListWidget extends ConsumerStatefulWidget {
  final Function tabController;
  CarWashLifeListWidget({
    required this.tabController,
    Key? key}) : super(key: key);

  @override
  ConsumerState<CarWashLifeListWidget> createState() => _CarWashLifeListWidgetState();
}

class _CarWashLifeListWidgetState extends ConsumerState<CarWashLifeListWidget> {
  @override
  Widget build(BuildContext context) {
    var community = ref.watch(hotAllCommunityProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '세차 라이프',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: TSizes.xs),
                Text(
                  '세차이야기를 나눠보세요',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                //await ref.read(categoryProvider.notifier).update((state) => "자유게시판");
                widget.tabController(
                  2,2
                );

                // THelperFunctions.navigateToScreen(context, const TCommunityCarWashLifeScreen());
                //THelperFunctions.navigateToScreen(context, const CommunityScreen());
              },
              child: Row(
                children: [
                  Text(
                    '더보기',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.blue,
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// ----------------------------------------------------------------
        /// 세차 라이프 리스트
        /// ----------------------------------------------------------------
        community.isEmpty
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: community.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return community[index].category == "세차라이프" ? CarWashLife(model: community[index]) : Container();
                  },
                ),
              )
      ],
    );
  }
}
