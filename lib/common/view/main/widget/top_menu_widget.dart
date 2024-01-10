import 'package:carwash/community/view/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../car/view/register_first_screen.dart';
import '../../../../community/provider/communityProvider.dart';
import '../../../const/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TopMenuWidget extends ConsumerWidget {
  const TopMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// 세차기록
        SizedBox(
          width: 150,
          child: OutlinedButton.icon(
            // 텍스트버튼에 아이콘 넣기
            onPressed: () =>context.goNamed(RecordFirstScreen.routeName),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
            ),
            icon: const Icon(
              Icons.airport_shuttle,
              color: Colors.deepOrangeAccent,
            ),
            label: Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Text(
                '세차기록',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),

        /// 커뮤니티
        SizedBox(
          width: 150,
          child: OutlinedButton.icon(
            // 텍스트버튼에 아이콘 넣기
            onPressed: () {
              context.goNamed(CommunityScreen.routeName);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
            ),
            icon: const Icon(
              Icons.family_restroom_outlined,
              color: Colors.deepOrangeAccent,
            ),
            label: Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Text(
                '커뮤니티',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
