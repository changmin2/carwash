import 'package:carwash/car/component/record_card.dart';
import 'package:carwash/car/repository/record_repository.dart';
import 'package:carwash/car/view/register_first_screen.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CarWashRecordScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordScreen';
  const CarWashRecordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CarWashRecordScreen> createState() => _CarWashRecordScreenState();
}

class _CarWashRecordScreenState extends ConsumerState<CarWashRecordScreen> {
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(recordRepositoryProvider).getRecord(date: _focusedDay.toString());
  }

  @override
  Widget build(BuildContext context) {

    return DefaultLayoutV2(

      floatingActionButton: _floatingActionButton(context),
      child: Column(
        children: [
          TableCalendar(
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextFormatter: (date, locale) =>
                    DateFormat.yMMMMd(locale).format(date),
                titleTextStyle: const  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
                headerPadding: const EdgeInsets.only(bottom: 20,top: 20),
                leftChevronPadding: const EdgeInsets.only(left: 50),
                rightChevronPadding: const EdgeInsets.only(right: 50),
                leftChevronIcon: const Icon(
                  Icons.arrow_left,
                  size: 40.0,
                ),
                rightChevronIcon: const Icon(
                  Icons.arrow_right,
                  size: 40.0,
                ),
              ),
              locale: 'ko_KR',
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2021,10,16),
              lastDay: DateTime.utc(2030,3,14),
              onDaySelected: (DateTime selectedDay,DateTime focusedDay){
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
              return isSameDay(_selectedDay, day);
            },
            // eventLoader: (day){
            //     return [Event('hi',true)];
            // },
          ),
          SizedBox(height: 16),
          RecordCard()

        ],
      )
    );
  }
}

class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}

FloatingActionButton _floatingActionButton(BuildContext context){

  return FloatingActionButton.extended(
    backgroundColor: Colors.green,
    onPressed: (){
      context.goNamed(RecordFirstScreen.routeName);
    },
    label: Text(
        "작성하기"
    ),
    icon: Icon(
      Icons.edit,
      size: 20,
    ),
  );
}
