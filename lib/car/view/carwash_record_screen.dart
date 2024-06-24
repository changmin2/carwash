import 'package:carwash/car/component/record_card.dart';
import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/car/provider/record_provider.dart';
import 'package:carwash/car/provider/state_provider.dart';
import 'package:carwash/car/view/record_detail_screen.dart';
import 'package:carwash/car/view/register_first_screen.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
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
  Map<String, List<Event>> events = {};
  Map<String, List<Event>> targetEvents = {};
  List<recordDto> eventList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> init() async {
    events = Map<String, List<Event>>();
    targetEvents = Map<String, List<Event>>();
    var flag = ref.watch(stateProvider);
    eventList = await ref.watch(RecordProvider('false').notifier).getRecord(flag.flag);
    //날짜 내림차순 정렬
    eventList.sort((a, b) => b.date.compareTo(a.date));
    if (flag.flag == true) {
      ref.read(stateProvider).change();
    }
    for (var o in eventList) {
      o = o as recordDto;
      //달력에 점 표시하기 위한 이벤트 리스트
      if (events.containsKey(o.date.toString().split(" ")[0])) {
        events[o.date.toString().split(" ")[0]]!.add(Event(o.id, o.memberId, o.imgUrl, o.washList, o.place, o.date));
      } else {
        events[o.date.toString().split(" ")[0]] = [Event(o.id, o.memberId, o.imgUrl, o.washList, o.place, o.date)];
      }

      //달력 하단에 달 마다 리스트를 보여주기 위한 이벤트 리스트
      if (targetEvents.containsKey(o.date.toString().split(" ")[0].substring(0, 7))) {
        targetEvents[o.date.toString().split(" ")[0].substring(0, 7)]!.add(Event(o.id, o.memberId, o.imgUrl, o.washList, o.place, o.date));
      } else {
        targetEvents[o.date.toString().split(" ")[0].substring(0, 7)] = [Event(o.id, o.memberId, o.imgUrl, o.washList, o.place, o.date)];
      }
    }
    return "sucess";
  }

  @override
  Widget build(BuildContext context) {
    //달력에서 그 달의 모든 세차기록을 보여주기 위한 기준 달
    var targetDay = _selectedDay.toString().split(" ")[0].substring(0, 7);

    /// 세차 기록 보기
    return DefaultLayoutV2(

      /// 작성하기 버튼
      floatingActionButton: _floatingActionButton(context),

      child: FutureBuilder(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(TSizes.defalutSpace),
              child: Column(
                children: [
                  /// 달력
                  TableCalendar(
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      // titleTextFormatter: (date, locale) => DateFormat.yMMMMd(locale).format(date),
                      titleTextFormatter: (date, locale) => DateFormat.yMMMM(locale).format(date),
                      titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      headerPadding: const EdgeInsets.only(bottom: 20),
                      // leftChevronPadding: const EdgeInsets.only(left: 50),
                      // rightChevronPadding: const EdgeInsets.only(right: 50),
                      leftChevronIcon: const Icon(
                        Icons.arrow_left,
                        size: 40.0,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.arrow_right,
                        size: 40.0,
                      ),
                    ),
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _selectedDay = focusedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    locale: 'ko_KR',
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2021, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    selectedDayPredicate: (DateTime day) {
                      // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                      return isSameDay(_selectedDay, day);
                    },
                    eventLoader: (day) {
                      return events[day.toString().split(" ")[0]] ?? [];
                    },
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// 해당일의 세차 기록 리스트
                  targetEvents[targetDay] == null
                      ? const SizedBox()
                      : Expanded(
                          child: ListView.builder(
                              itemCount: targetEvents[targetDay]!.length,
                              itemBuilder: (BuildContext context, int idx) {
                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(RecordDetail.routeName, pathParameters: {'id': targetEvents[targetDay]![idx].id.toString()});
                                  },
                                  child: RecordCard(record: targetEvents[targetDay]![idx]),
                                );
                              }),
                        ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

FloatingActionButton _floatingActionButton(BuildContext context) {
  return FloatingActionButton.extended(
    backgroundColor: PRIMARY_COLOR,
    onPressed: () {
      context.goNamed(RecordFirstScreen.routeName);
    },
    label: Text(
      '작성하기',
      style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white),
    ),
    icon: const Icon(
      Iconsax.path,
      color: Colors.white,
    ),
  );
}
