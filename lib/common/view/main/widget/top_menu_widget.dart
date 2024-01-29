import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/common/view/dilution/dilution_screen.dart';
import 'package:carwash/community/view/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../car/view/register_first_screen.dart';

class TopMenuWidget extends ConsumerWidget {
  const TopMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // /// 세차기록
        // SizedBox(
        //   width: 150,
        //   child: OutlinedButton.icon(
        //     // 텍스트버튼에 아이콘 넣기
        //     onPressed: () =>context.goNamed(RecordFirstScreen.routeName),
        //     style: const ButtonStyle(
        //       backgroundColor: MaterialStatePropertyAll(Colors.white),
        //     ),
        //     icon: const Icon(
        //       Icons.airport_shuttle,
        //       color: Colors.deepOrangeAccent,
        //     ),
        //     label: Padding(
        //       padding: const EdgeInsets.only(left: TSizes.sm),
        //       child: Text(
        //         '세차기록',
        //         style: Theme.of(context).textTheme.headlineSmall,
        //       ),
        //     ),
        //   ),
        // ),

        // /// 커뮤니티
        // SizedBox(
        //   width: 150,
        //   child: OutlinedButton.icon(
        //     // 텍스트버튼에 아이콘 넣기
        //     onPressed: () {
        //       context.goNamed(CommunityScreen.routeName);
        //     },
        //     style: const ButtonStyle(
        //       backgroundColor: MaterialStatePropertyAll(Colors.white),
        //     ),
        //     icon: const Icon(
        //       Icons.family_restroom_outlined,
        //       color: Colors.deepOrangeAccent,
        //     ),
        //     label: Padding(
        //       padding: const EdgeInsets.only(left: TSizes.sm),
        //       child: Text(
        //         '커뮤니티',
        //         style: Theme.of(context).textTheme.headlineSmall,
        //       ),
        //     ),
        //   ),
        // ),
        
        /// 세차기록
        GestureDetector(
          onTap: () => context.goNamed(RecordFirstScreen.routeName),
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
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          ),
        ),

        /// 커뮤니티
        GestureDetector(
          onTap: () => context.goNamed(CommunityScreen.routeName),
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
                  style: Theme.of(context).textTheme.headlineSmall,
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
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          ),
        ),


      ],
    );
  }
}
