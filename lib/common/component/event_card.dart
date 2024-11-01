import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final int index;
  const EventCard({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 80,
      child:
      Card(
        color: index == 0 ? const Color(0xffFFF3D9) : const Color(0xffE5FDEB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                index == 0 ?
                '자신만의 세차 방법을 기록해 보세요!'
                : '나만의 세차 순서를 등록해 보세요!'
                ,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                index == 0 ?
                '세차 커뮤니티를 통해 소통해 보세요!'
                :'자주 사용하는 용품을 등록해 보세요!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
