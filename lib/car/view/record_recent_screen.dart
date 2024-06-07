import 'package:carwash/car/component/washlist_card.dart';
import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/car/provider/record_provider.dart';
import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RecordRecent extends ConsumerStatefulWidget {
  static get routeName => 'recordDetailScreen';
  final recordDto model;
  const RecordRecent({required this.model, Key? key}) : super(key: key);

  @override
  ConsumerState<RecordRecent> createState() => _RecordDetailState();
}

class _RecordDetailState extends ConsumerState<RecordRecent> {
  @override
  Widget build(BuildContext context) {
    var wash = widget.model.washList.split("[")[1].split("]")[0].split(",");

    return DefaultLayoutV2(

      appBar: AppBar(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 세차일자
              Text(
                '세차 일자',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              TRoundedContainer(
                showBorder: true,
                child: ListTile(
                  title: Text(
                    '${DateFormat('yyyy년 MM월 dd일 ').format(widget.model.date.add(new Duration(days: 1)))}(${DateFormat('E', 'ko').format(widget.model.date.add(new Duration(days: 1)))})',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              
              /// 세차 장소
              Text(
                '세차 장소',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              TRoundedContainer(
                showBorder: true,
                child: ListTile(
                  title: Text(
                    widget.model.place,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              
              /// 사진
              Text(
                '사진',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              TRoundedImage(
                imageUrl: widget.model.imgUrl,
                width: 400,
                height: 200,
                isNetworkImage: true,
                fit: BoxFit.fill,
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              
              /// 세차 순서
              Text(
                '세차 순서',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 3,
                  runSpacing: 3,
                  alignment: WrapAlignment.start,
                  children: List.generate(wash.length, (index) {
                    return WashListCard(step: index + 1, wash: wash[index]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
