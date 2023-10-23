import 'package:carwash/car/view/carwash_record_screen.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../const/colors.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const  RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab> with SingleTickerProviderStateMixin{
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.animateTo(index);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    //controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          MainScreen(),
          CarWashRecordScreen()
        ],
      ),
      bottomNavagtionBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        onTap: (int index){
          controller.animateTo(index);
          controller.addListener(tabListener);
        },
        showUnselectedLabels: true,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: '세차기록'
          ),
        ],
      ),
    );
  }

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

}
