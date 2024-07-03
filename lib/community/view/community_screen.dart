import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:carwash/community/view/community_carwash_life/community_carwash_life_screen.dart';
import 'package:carwash/community/view/community_question/community_question_screen.dart';
import 'package:carwash/community/view/community_register_screen.dart';
import 'package:carwash/community/view/community_free/community_free_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/widgets/tabbar.dart';
import '../provider/category_provider.dart';
import 'community_all/community_all_screen.dart';


class CommunityScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityScreen';
  var nowscreen;
  CommunityScreen({
    this.nowscreen = 0,
    Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> with TickerProviderStateMixin{

  var category = ['','자유게시판','세차라이프','질문게시판'];
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.nowscreen,
    );

    tabController.addListener(tabListener);
    tabController.animateTo(widget.nowscreen);
  }

  void tabListener() {
    setState(() {
      widget.nowscreen = tabController.index;
    });
  }




  @override
  Widget build(BuildContext context) {

    ref.read(communityProvider.notifier).init();

    return DefaultTabController(
      length: 4,
      child: DefaultLayoutV2(
        appBar: AppBar(
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(TSizes.defalutSpace),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TTabBar(
                onTap: (index){
                  setState(() {
                    tabController.animateTo(index);
                    ref.read(categoryProvider.notifier).update((state) => category[index]);
                  });


                },

                tabs: const [
                  Tab(child: Text('전체', style: TextStyle(fontSize: 16))),
                  Tab(child: Text('자유게시판', style: TextStyle(fontSize: 16))),
                  Tab(child: Text('세차라이프', style: TextStyle(fontSize: 16))),
                  Tab(child: Text('질문게시판', style: TextStyle(fontSize: 16))),
                ],
                tabController: tabController,
              ),
            ),
          ),
        ),
        floatingActionButton: _floatingActionButton(context),
        child: TabBarView(
          controller: tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            /// 전체 탭 화면
            TCommunityAllScreen(),
            TCommunityFreeScreen(),
            TCommunityCarWashLifeScreen(),
            TCommunityQuestionScreen(),
          ],
        ),
      ),
    );
  }
  FloatingActionButton _floatingActionButton(BuildContext context) {

    return FloatingActionButton.extended(
      backgroundColor: PRIMARY_COLOR,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CommunityRegisterScreen(
              category: category[widget.nowscreen] == '' ? '자유게시판' : category[widget.nowscreen],
            ))
        );
      },
      label: Text(
        '글쓰기',
        style: Theme.of(context).textTheme.titleMedium!.apply(color: Colors.white),
      ),
      icon: const Icon(
        Iconsax.path,
        color: Colors.white,
      ),
    );
  }

}


