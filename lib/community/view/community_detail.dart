import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/component/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityDetailScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityDetailScreen';
  const CommunityDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends ConsumerState<CommunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(
        title: Text(
          '오늘은 비가 주르륵...'
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 400,
              child: SingleChildScrollView(
                  child: Text('contet\nddddddd\ndddddd\ndddddd\nddddd\ndfdfasdfasd\nfasdfdasfa\nfasdfadsfasfcontet\nddddddd\ndddddd\ndddddd\nddddd\ndfdfasdfasd\nfasdfdasfa\nfasdfadsfasfcontet\nddddddd\ndddddd\ndddddd\nddddd\ndfdfasdfasd\nfasdfdasfa\nfasdfadsfasfcontet\nddddddd\ndddddd\ndddddd\nddddd\ndfdfasdfasd\nfasdfdasfa\nfasdfadsfasfcontet\nddddddd\ndddddd\ndddddd\nddddd\ndfdfasdfasd\nfasdfdasfa\nfasdfadsfasfcontet\nddddddd\ndddddd\ndddddd\nddddd\ndfdfasdfasd\nfasdfdasfa\nfasdfadsfasf')
              ),
            ),
            const SizedBox(height: 20),
            Divider(thickness: 1, height: 1,color: PRIMARY_COLOR),
            const SizedBox(height: 16),
            Text(
              '댓글',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 25,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      )
    );
  }
}
