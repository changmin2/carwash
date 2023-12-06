import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/component/community_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    );
  }
}
