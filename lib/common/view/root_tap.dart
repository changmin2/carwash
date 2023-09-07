import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../const/colors.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab> with SingleTickerProviderStateMixin{



  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
        ],
      ),
    );
  }

}
