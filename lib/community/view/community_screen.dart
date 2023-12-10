import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/component/community_card.dart';
import 'package:carwash/community/view/community_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityScreen';

  const CommunityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: CommunityCard(),
      floatingActionButton: _floatingActionButton(context),
    );
  }
}

FloatingActionButton _floatingActionButton(BuildContext context){
  return FloatingActionButton.extended(
      backgroundColor: Colors.red,
      onPressed: (){
        context.goNamed(CommunityRegisterScreen.routeName);
      },
      label: Text(
        '글쓰기',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18
        ),
      ),
      icon: Icon(
        Icons.edit,
        color: Colors.white,
      ),
  );
}