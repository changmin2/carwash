import 'package:carwash/car/view/carwash_record_screen.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/view/main/main_screen.dart';
import 'package:carwash/community/view/community_screen.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:carwash/user/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../const/colors.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 4,
      vsync: this,

      /// 탭 변경 애니메이션 시간
      animationDuration: const Duration(milliseconds: 0),
    );
    _tabController.animateTo(_selectIndex);
    // ref.read(WeatherProvider.notifier).getWeather();
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    //controller.dispose();

    super.dispose();
  }

  void tabListener() {
    setState(() {
      _selectIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      bottomNavagtionBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.white,
          onTap: (int index) {
            _tabController.animateTo(index);
            _tabController.addListener(tabListener);
          },
          currentIndex: _selectIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Iconsax.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Iconsax.message_edit), label: '세차기록'),
            BottomNavigationBarItem(icon: Icon(Iconsax.messages_3), label: '커뮤니티'),
            BottomNavigationBarItem(icon: Icon(Iconsax.user), label: '내정보'),
          ],
        ),
      ),
      child: DefaultTabController(
        length: 4,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const [
            MainScreen(),
            CarWashRecordScreen(),
            CommunityScreen(),
            UserProfileScreen(),
          ],
        ),
      ),
    );
  }
}
