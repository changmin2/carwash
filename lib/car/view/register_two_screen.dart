import 'package:carwash/car/component/select_card.dart';
import 'package:carwash/car/provider/select_provider.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordTwoScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordTwo';
  final query;

  const RecordTwoScreen({
    this.query,
    Key? key}) : super(key: key);
  @override
  ConsumerState<RecordTwoScreen> createState() => _RecordTwoScreenState();
}

class _RecordTwoScreenState extends ConsumerState<RecordTwoScreen> {
  var newList = [];
  static get routeName => 'recordTwo';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newList = widget.query.toString().split('[')[1].toString().split(']')[0].toString().split(',').toList();
  }
  @override
  Widget build(BuildContext context) {


    return DefaultLayoutV2(
        appBar: _renderAppbar(context),
        child: Center(
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
              //trailing: ReorderableDragStartListener(
              //                             index: index, child: Icon(Icons.drag_handle)),
              SizedBox(height: 25),
              Expanded(
                child: ReorderableListView.builder(
                    itemCount: newList.length,
                    itemBuilder: (context, index) {
                      String washType = newList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(width: 0.5)
                        ),
                        key: ValueKey(washType),
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Icon(
                            Icons.do_not_disturb_on_total_silence_rounded
                          ),
                          contentPadding: const EdgeInsets.all(25),
                          title: Text(
                            washType,
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: ReorderableDragStartListener(
                                                 index: index, child: Icon(Icons.drag_handle)),
                          onTap: () {/* Do something else */},
                        ),
                      );
                    },
                    // The reorder function
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final element = newList.removeAt(oldIndex);
                        newList.insert(newIndex, element);
                      });
                    },

                    ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
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
                          onPressed: (){},
                          child: Text(
                            '다음 단계',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          )
                      ),
                    )
                  ]
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
