import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/component/community_card.dart';
import 'package:carwash/community/provider/category_provider.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:carwash/community/view/community_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/view/pagination_list_view.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityScreen';

  const CommunityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(communityProvider.notifier).init();
  }
  @override
  Widget build(BuildContext context) {

    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: (){
                        ref.read(categoryProvider.notifier).update((state) => '');
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        child: Card(
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              '전체',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: (){
                        ref.read(categoryProvider.notifier).update((state) => '자유게시판');
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        child: Card(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              '자유게시판',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: (){
                        ref.read(categoryProvider.notifier).update((state) => '세차라이프');
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        child: Card(
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              '세차라이프',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: (){
                        ref.read(categoryProvider.notifier).update((state) => '질문게시판');
                      },
                      child: Container(
                        width: 120,
                        height: 30,
                        child: Card(
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              '질문게시판',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PaginationListView(
                  provider: communityProvider,
                  itemBuilder: <CommunityModel>(_,index,community){
                    return CommunityCard(community: community);
                  }),
            ),
          ],
      ),
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