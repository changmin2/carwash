import 'package:carwash/car/component/select_card.dart';
import 'package:carwash/car/provider/select_provider.dart';
import 'package:carwash/car/view/register_two_screen.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecordFirstScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordFirst';

  const RecordFirstScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RecordFirstScreen> createState() => _RecordFirstScreenState();
}

class _RecordFirstScreenState extends ConsumerState<RecordFirstScreen> {
  final washList = ['매트세척','시트세정','시트코팅','휠세척','고압수','프리워시','스노우폼','본세차'
        ,'철분제거','페인트클렌저','클레잉','유막제거','발수코팅','폴리싱','탈지','실런트'
        ,'고체왁스','물왁스','드라잉','타이어코팅','휠코팅','엔진룸세척','트렁크정리'];
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(SelectProvider);
    return DefaultLayoutV2(
      appBar: _renderAppbar(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                '나만의 세차를 기록하고 공유해보세요!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                ),
              ),
            ),
            SizedBox(height: 30),
            Wrap(
                direction: Axis.horizontal, // 정렬 방향
                alignment: WrapAlignment.center, // 정렬 방식
                spacing: 10,  // 상하(좌우) 공간
                runSpacing: 10, // 좌우(상하) 공간
                children: List.generate(washList.length, (i)=> SelectCard(select: state.selects[i], index: i,))
              // WsmBoxWidget()
            ),
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.grey,
                    animationDuration: Duration(milliseconds: 1000),
                    primary: Colors.black,
                    shadowColor: Colors.black,
                    minimumSize: Size(350,50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    var newList = [];
                    newList = await washList.where((element) => state.selects[washList.indexOf(element)]==1).toList();
                    context.goNamed(
                        RecordTwoScreen.routeName,
                        queryParameters: {"query":newList.toString()}
                    );
                  },
                  child: Text(
                      '다음 단계',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}

AppBar _renderAppbar(BuildContext context){
  return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back,size: 30),
          color: Colors.brown,
          alignment: Alignment.centerLeft,
        ),
      )
  );
}
