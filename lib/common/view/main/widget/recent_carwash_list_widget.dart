import 'package:carwash/car/provider/recentRecord_provider.dart';
import 'package:carwash/car/view/record_recent_screen.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
  const RecentCarWashListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<RecentCarWashListWidget> createState() => _RecentCarWashListWidgetState();
}

class _RecentCarWashListWidgetState extends ConsumerState<RecentCarWashListWidget> {

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userMeProvider) as UserModel;
    var record = ref.watch(recentRecordProvider(user.username));

    return record.length == 0
          ? Column(
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '최근 세차',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    onPressed: () {
                      THelperFunctions.navigateToScreen(context, const CarWashRecordScreen());
                    },
                    child: Text(
                      'See all',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '최근 세차가 없습니다.',
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ]
          )
          :

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '최근 세차',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    onPressed: () {
                      THelperFunctions.navigateToScreen(context, const CarWashRecordScreen());
                    },
                    child: Text(
                      'See all',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                height: (82 * record.length).toDouble(),
                child: ListView.builder(
                    itemCount: record.length,
                    itemBuilder: (context,idx){
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecordRecent(
                                model: record[idx])));
                          },
                          child: RecentCarWashCard(record: record[idx]));
                }),
              )
            ],
          );
        }
}
