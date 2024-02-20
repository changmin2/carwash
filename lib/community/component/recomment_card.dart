import 'package:carwash/community/provider/communityProvider.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../common/const/sizes.dart';
import '../../user/model/user_model.dart';
import '../model/comment_model.dart';
import '../provider/comment_provider.dart';
import '../provider/hot_all_community_provider.dart';
import '../provider/hot_free_community_provider.dart';

class ReCommentCard extends ConsumerWidget {

  final Recomment recomment;
  final String username;
  final int comment_id;
  final int board_id;
  int flag;

  ReCommentCard({
    required this.board_id,
    required this.recomment,
    required this.username,
    required this.comment_id,
    this.flag = 0,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.watch(commentProvider(board_id));
    final user = ref.read(userMeProvider) as UserModel;
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '┗',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recomment.content,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      /// 댓글 아이디
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width/4,
                            child: Text(
                              recomment.creator,
                              style: Theme.of(context).textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          /// 댓글 아이디
                          Text(
                            recomment.createDate.toString().split(" ")[0],
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          (recomment.creator == user.nickname || recomment.creator == 'superadmin1') ?
                          _PopupMenuButtonPage(context, ref, recomment.recomment_id, comment_id,board_id,flag)
                              :_NoCreatorPopupMenuButtonPage(context, ref, recomment.recomment_id, comment_id)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ]
        ),
      ),
    );
  }
}


PopupMenuButton _PopupMenuButtonPage (BuildContext context,WidgetRef ref,int recomment_id,int commnet_id,int board_id,int flag){
  return PopupMenuButton(
    onSelected: (value)async{
      if(value=='신고') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('신고되었습니다. 누적된 신고자는 블라인드 처리 됩니다.'),
              duration: Duration(seconds: 1),
            )
        );
      }else if(value == '삭제'){
        await ref.read(commentProvider(board_id).notifier).deleteReComment(recomment_id,commnet_id);
        await flag == 0 ? ref.read(communityProvider.notifier).downCommentCnt(board_id,1)
          : flag == 1 ? ref.read(hotAllCommunityProvider.notifier).downCommentCnt(board_id,1): ref.read(hotFreeCommunityProvider.notifier).downCommentCnt(board_id,1);

    }
    },
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: '신고',
          child: Text('신고'),
        ),
        PopupMenuItem(
          value: '삭제',
          child: Text('삭제'),
        )
      ];
    },
  );
}


PopupMenuButton _NoCreatorPopupMenuButtonPage (BuildContext context,WidgetRef ref,int recomment_id,int commnet_id){
  return PopupMenuButton(
    onSelected: (value){
      if(value=='신고'){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('신고되었습니다. 누적된 신고자는 블라인드 처리 됩니다.'),
              duration: Duration(seconds: 1),
            )
        );
      }
    },
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: '신고',
          child: Text('신고'),
        ),
      ];
    },
  );
}
