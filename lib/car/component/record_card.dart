import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/component/rounded_container.dart';

class RecordCard extends StatelessWidget {
  final Event record;

  const RecordCard({required this.record, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 80,
      showBorder: true,
      padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              /// 아이콘
              Image.asset('asset/img/record.png'),

              const SizedBox(width: TSizes.spaceBtwItems),

              /// 세차 기록 정보
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 날짜
                  Text(record.date.toString().split(" ")[0]),

                  const SizedBox(height: TSizes.xs),

                  /// 장소
                  Text(record.place)
                ],
              ),
            ],
          ),
          
          /// 자세히 보기 아이콘
          const Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}

class Event {
  int id;
  String memberId;
  String imgUrl;
  String washList;
  String place;
  DateTime date;
  Event(this.id, this.memberId, this.imgUrl, this.washList, this.place, this.date);
}
