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
    events = [];
    eventList = ref.read(accountBookProvider.notifier).get();

    for (var o in eventList) {
      events.add(
        Event(
            pay: o.cost,
            child: Stack(
              children:[
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: o.category == '지출'
                            ? Color.fromRGBO(255, 250, 230, 100)
                            : o.category == '정비'
                            ? Color.fromRGBO(248, 244, 225, 100)
                            : Color.fromRGBO(255, 249, 208, 100),
                        radius: 30,
                        child: FittedBox(
                          child: o.category == '지출'
                                 ? Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Color.fromRGBO(255, 95, 0 , 100),
                                  )
                                  : o.category == '정비'
                                ? Icon(
                                    Icons.build_outlined,
                                    color: Color.fromRGBO(116,81, 45 , 100),
                                  )
                              :   Icon(
                                    Icons.water_drop_outlined,
                                    color: Color.fromRGBO(90,178, 255 , 100),
                                  )
                        ),
                      ),
                      title: Text(
                        o.title
                      ),
                      subtitle: Text(
                        o.date.toString().split(" ")[0]
                      ),
                      trailing: Text(
                        '- ' + o.cost.toString()+' 원',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0,103, 105 , 100)
                        ),
                      ),
                    ),
                ),
                Positioned(
                    right: -10,
                    top: -10,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,

                      ),

                    )
                ),
              ]
            ),
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

          if (snapshot.hasData == false) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Flexible(
                  child: EventCalendar(
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
                  ),
                )
              ],
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