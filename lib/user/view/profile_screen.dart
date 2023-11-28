import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static get routeName => 'userProfileScreen';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
        appBar: _renderAppbar(context),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              ref.read(userMeProvider.notifier).logout();
            },
            child: Text('로그아웃'),

          )
        )
    );
  }
}

AppBar _renderAppbar(BuildContext context){
  return AppBar(
    leading: BackButton(

    ),
    // backgroundColor: Colors.white,
    // centerTitle: true,
    // elevation: 0,
    // leading: Padding(
    //   padding: EdgeInsets.only(left: 10),
    //   child: IconButton(
    //     onPressed: (){Navigator.pop(context);},
    //     icon: Icon(Icons.arrow_back,size: 30),
    //     color: Colors.brown,
    //     alignment: Alignment.centerLeft,
    //   ),
    // )
  );
}
