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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(SelectProvider);
    return DefaultLayoutV2(
      appBar: _renderAppbar(context),
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
          SizedBox(height: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width:  MediaQuery.of(context).size.width,
                  child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: SelectCard(
                          index: index,
                          select: state.selects[index],
                        ),
                      );
                    },
                  ),
              ),
              SizedBox(height: 100),
              ElevatedButton(
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
                  onPressed: (){
                    context.goNamed(RecordTwoScreen.routeName);
                  },
                  child: Text(
                      '다음 단계',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                  )
              )
          ]
          ),
        ],
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
