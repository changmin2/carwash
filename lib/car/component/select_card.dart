import 'package:carwash/car/provider/select_provider.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCard extends ConsumerStatefulWidget {
  final int index;
  final int select;

  const SelectCard({
    required this.index,
    required this.select,
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends ConsumerState<SelectCard> {
  final washList = ['매트세척','시트세정','시트코팅','휠세척','고압수','프리워시','스노우폼','본세차'
    ,'철분제거','페인트클렌저','클레잉','유막제거','발수코팅','폴리싱','탈지','실런트'
    ,'고체왁스','물왁스','드라잉','타이어코팅','휠코팅','엔진룸세척','트렁크처리'];
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(SelectProvider);
    return GestureDetector(
      onTap: (){
        ref.read(SelectProvider.notifier).select(widget.index);
      },
      child: SizedBox(
        width: washList[widget.index].length*25,
        height: 55,
        child: Card(
          elevation: 1,
          color: widget.select == 0 ? Colors.white : PRIMARY_COLOR,
          child: Center(
            child: Text(
              washList[widget.index],
              style: TextStyle(
                color: widget.select == 0 ? Colors.black : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ),
      ),
    );
  }
}
