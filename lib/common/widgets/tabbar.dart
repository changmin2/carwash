import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final ValueChanged onTap;

  const TTabBar({
    super.key,
    required this.tabs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.center,
      tabs: tabs,
      isScrollable: true,
      indicatorColor: PRIMARY_COLOR,
      unselectedLabelColor: Colors.grey,
      labelColor: PRIMARY_COLOR,
      onTap: onTap,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
