import 'package:carwash/car/component/washlist_card.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

///-------------------------------------------------------
///-------------------------------------------------------
/// 다른 회원 정보 화면의 세차순서 위젯
///-------------------------------------------------------
///-------------------------------------------------------
class MemberInfoCarWashSeqWidget extends StatelessWidget {
  final List<String> records;
  MemberInfoCarWashSeqWidget({
    super.key,
    required this.records
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '세차 순서',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(width: TSizes.sm),

            ///*************************************
            /// 세차 순서 갯수 - 그냥 무조건 숫자 보여줘~
            ///*************************************
            Text(
              records.length.toString(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: PRIMARY_COLOR),
            ),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// 세차 순서 리스트
        _carWashSeqList(context),
      ],
    );
  }

  SizedBox _carWashSeqList(context) {
    ///*************************************
    /// 1. 본인 세차용품 등록 X
    ///*************************************
    if (records.length == -1) {
      return SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  '회원님의 세차순서를 먼저 등록해주세요.',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.redAccent),
                ),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            ///-------------------------------------------------------
            /// 등록하기 버튼
            ///-------------------------------------------------------
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent),
                ),
                onPressed: () {},
                child: Text(
                  '등록하기',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      ///*************************************
      /// 2-1. 본인 세차순서 등록 O
      ///      건수가 없으면 없다는 글만.
      ///*************************************
      if (records.length == 0) {
        return SizedBox(
          height: 100,
          child: Center(
            child: Text(
              '등록된 세차순서가 없습니다.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
      } else {
        ///*************************************
        /// 2-2. 본인 세차순서 등록 O
        ///      건수가 있으면 리스트 생성
        ///*************************************
        return SizedBox(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 3,
            runSpacing: 3,
            alignment: WrapAlignment.start,
            children: List.generate(records.length, (index) {
              return WashListCard(step: index + 1, wash: records[index].trim());
            }).toList(),
          ),
        );
      }
    }
  }
}
