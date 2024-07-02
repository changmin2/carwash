import 'package:carwash/car/provider/recentRecord_provider.dart';
import 'package:carwash/car/view/record_recent_screen.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../car/model/recentRecordDto.dart';
import '../../../../car/model/recordDto.dart';
import '../../../../car/repository/record_repository.dart';
import '../../../../car/view/carwash_record_screen.dart';
import '../../../../car/view/record_detail_screen.dart';
import '../../../../user/model/user_model.dart';
import '../../../component/recent_carwash_card.dart';
import '../../../const/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

/// main_screen 에서 최근 세차 영억
class RecentCarWashListWidget extends ConsumerStatefulWidget {

  final List<recordDto> record;
  final Function tabController;
  RecentCarWashListWidget({
    required this.record,
    required this.tabController,
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<RecentCarWashListWidget> createState() => _RecentCarWashListWidgetState();
}

class _RecentCarWashListWidgetState extends ConsumerState<RecentCarWashListWidget> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '최근 세차',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: TSizes.xs),
                Text(
                  '회원님이 세차한 기록이에요',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: const Color(0xff9E9E9E)),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                widget.tabController(1,2);
                //THelperFunctions.navigateToScreen(context, const CarWashRecordScreen());
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
        /// 세차 기록 리스트
        /// ----------------------------------------------------------------
        widget.record.isEmpty
            ? const CircularProgressIndicator()
            : widget.record[0].id == 00
                ? Text(
                    '세차기록이 없습니다.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : SizedBox(
                    height: (70 * widget.record.length).toDouble(),
                    child: ListView.builder(
                        itemCount: widget.record.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, idx) {
                          return GestureDetector(
                            onTap: () {
                              THelperFunctions.navigateToScreen(
                                context,
                                RecordRecent(model: widget.record[idx]),
                              );
                            },
                            child: RecentCarWashCard(record: widget.record[idx]),
                          );
                        }),
                  )
      ],
    );
  }
}
