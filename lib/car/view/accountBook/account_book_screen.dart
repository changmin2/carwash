import 'package:carwash/car/model/accountBookDto.dart';
import 'package:carwash/car/provider/accountBook_provider.dart';
import 'package:carwash/car/view/accountBook/account_register_screen.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/const/colors.dart';

class AccountBookScreen extends ConsumerStatefulWidget {
  const AccountBookScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountBookScreen> createState() => _AccountBookScreenState();
}

class _AccountBookScreenState extends ConsumerState<AccountBookScreen> {

  List<AccountBookDto> eventList = [];
  List<Event> events = [];

  Future<String> init() async {
    eventList = ref.read(accountBookProvider.notifier).get();

    for (var o in eventList) {
      events.add(
        Event(
            pay: o.cost,
            child: Text(o.category),
            dateTime: CalendarDateTime(
              year: int.parse(o.date.toString().split(" ")[0].substring(0,4)),
              month: int.parse(o.date.toString().split(" ")[0].substring(5,7)),
              day: int.parse(o.date.toString().split(" ")[0].substring(8,10)),
              calendarType: CalendarType.GREGORIAN,

            ),
        )
      );
    }

    return "sucess";
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(accountBookProvider);
    return DefaultLayoutV2(
      appBar: AppBar(),
      floatingActionButton: _floatingActionButton(context),
      child: FutureBuilder(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print(snapshot);
          if (snapshot.hasData == false) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
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
                    dayOptions: DayOptions(
                        eventCounterViewType: DayEventCounterViewType.LABEL
                    ),
                    showLoadingForEvent: true,
                    events: events
                  )
                ],
              ),
            );
          }
        }
      ),
    );
  }
}

FloatingActionButton _floatingActionButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: PRIMARY_COLOR,
    onPressed: () {
      THelperFunctions.navigateToScreen(context, AccountRegisterScreen());
    },
    child: Icon(
      Icons.add,
      color: Colors.white,
    ),
  );
}