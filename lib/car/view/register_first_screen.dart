import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';

class RecordFirstScreen extends StatefulWidget {
  static get routeName => 'recordFirst';

  const RecordFirstScreen({Key? key}) : super(key: key);

  @override
  State<RecordFirstScreen> createState() => _RecordFirstScreenState();
}

class _RecordFirstScreenState extends State<RecordFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: _renderAppbar(context),
      child: Column(
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
          )
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
