import 'package:carwash/car/view/accountBook/account_register_screen.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:go_router/go_router.dart';

import '../../../common/const/colors.dart';

class AccountBookScreen extends StatelessWidget {
  const AccountBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
        appBar: AppBar(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              EventCalendar(
                calendarType: CalendarType.GREGORIAN,
                calendarLanguage: 'en',
                calendarOptions: CalendarOptions(
                  toggleViewType: true,
                  viewType: ViewType.DAILY,
                  headerMonthBackColor: Colors.white
                ),
                showLoadingForEvent: true,
                events: [
                  // Event(
                  //     child: Text('hi'),
                  //     dateTime: CalendarDateTime(
                  //       year: 2024,
                  //       month: 4,
                  //       day: 16,
                  //       calendarType: CalendarType.GREGORIAN
                  //     )
                  // ),
                  // Event(
                  //     child: Text('hi'),
                  //     dateTime: CalendarDateTime(
                  //         year: 2024,
                  //         month: 4,
                  //         day: 16,
                  //         calendarType: CalendarType.GREGORIAN
                  //     )
                  // )
                ],
              )
            ],
          ),
        ),
        floatingActionButton: _floatingActionButton(context)
    );
  }
}

FloatingActionButton _floatingActionButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: PRIMARY_COLOR,
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog.adaptive(
              backgroundColor: Colors.white,
              content: Text(
                  '원하는 지출항목을 선택하세요.',
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: (){
                            context.pop();
                            THelperFunctions.navigateToScreen(context, AccountRegisterScreen());
                          },
                          child: Text('hi')
                      )
                    ],
                  ),
                )
              ],
            );
          }
      );
    },
    child: Icon(
      Icons.add,
      color: Colors.white,
    ),
  );
}