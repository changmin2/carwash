import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

class WashListCard extends StatelessWidget {
  final int step;
  final String wash;
  const WashListCard({required this.step, required this.wash, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 80,
      height: 80,
      showBorder: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 숫자 아이콘
          renderIcon(step),
          
          const SizedBox(height: TSizes.sm),
          
          /// 세차 기록
          Text(
            wash.trim(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

Widget renderIcon(int step) {
  if (step == 1) {
    return const Icon(
      Icons.filter_1_outlined,
    );
  } else if (step == 2) {
    return const Icon(Icons.filter_2_outlined);
  } else if (step == 3) {
    return const Icon(Icons.filter_3_outlined);
  } else if (step == 4) {
    return const Icon(Icons.filter_4_outlined);
  } else if (step == 5) {
    return const Icon(Icons.filter_5_outlined);
  } else if (step == 6) {
    return const Icon(Icons.filter_6_outlined);
  } else if (step == 7) {
    return const Icon(Icons.filter_7_outlined);
  } else if (step == 8) {
    return const Icon(Icons.filter_8_outlined);
  } else if (step == 9) {
    return const Icon(Icons.filter_9_outlined);
  } else {
    return const SizedBox();
  }
}
