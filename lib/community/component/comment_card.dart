import 'package:carwash/community/component/comment_register_screen.dart';
import 'package:carwash/community/component/recomment_card.dart';
import 'package:carwash/community/model/comment_model.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/sizes.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../provider/comment_provider.dart';
import '../provider/hot_all_community_provider.dart';
import '../provider/hot_free_community_provider.dart';

class CommentCard extends ConsumerWidget {
  final CommentModel comment;
  final List<Recomment>? recomments;
  final int board_id;
  int flag;
  CommentCard({
    required this.comment,
    required this.recomments,
    required this.board_id,
    this.flag = 0,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user = ref.read(userMeProvider) as UserModel;
    int recommentsCnt = recomments == null ? 1 : recomments!.length+1;
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 댓글 내용
          Text(
            comment.content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// 댓글 아이디
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    comment.creator,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  /// 댓글 아이디
                  Text(
                    comment.createDate.toString().split(" ")[0],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 55),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      comment.creator == user.username ?
                      _PopupMenuButtonPage(context, ref, comment.comment_id, board_id,recommentsCnt,flag)
                          :_NoCreatorPopupMenuButtonPage(context, ref, comment.comment_id, board_id,flag)
                    ]
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          const Divider(color: Colors.grey),

          const SizedBox(height: TSizes.spaceBtwItems),


          /// 대댓글 내용
          recomments?.length != 0
          ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recomments!.length,
                      itemBuilder: (BuildContext context,int index){
                        return ReCommentCard(
                            board_id : board_id,
                            recomment: recomments![index],
                            username: 'cc',
                            comment_id: comment.comment_id,
                            flag: flag
                        );
                      }): Container(),
          const SizedBox(height: TSizes.spaceBtwItems),
        ],
      )
    );
  }
}

PopupMenuButton _PopupMenuButtonPage (BuildContext context,WidgetRef ref,int comment_id,int board_id,int recommentsCnt,flag){
  return PopupMenuButton(
    onSelected: (value) async {
      if(value=='삭제') {
        if(context.mounted){
          await ref.read(commentProvider(board_id).notifier).deleteComment(comment_id);
          await flag == 0 ? ref.read(communityProvider.notifier).downCommentCnt(board_id,recommentsCnt)
              : flag == 1 ? ref.read(hotAllCommunityProvider.notifier).downCommentCnt(board_id,recommentsCnt): ref.read(hotFreeCommunityProvider.notifier).downCommentCnt(board_id,recommentsCnt);

        }
        //댓글 밑에 달린 대댓글 갯수를 가져오지 않고 다시 업데이트
      }else if(value=='신고'){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('신고되었습니다. 누적된 신고자는 블라인드 처리 됩니다.'),
              duration: Duration(seconds: 1),
            )
        );
      }else  if(value=='대댓글'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CommentRegisterScreen(id: board_id,comment_id : comment_id,flag: flag,)));
      }
    },
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          value: '대댓글',
          child: Text('대댓글'),
        ),
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


PopupMenuButton _NoCreatorPopupMenuButtonPage (BuildContext context,WidgetRef ref,int comment_id,int recipe_id,int flag){
  return PopupMenuButton(
    onSelected: (value){
      if(value=='대댓글'){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CommentRegisterScreen(id: recipe_id,comment_id : comment_id,flag: flag,)));
      }
      else if(value=='신고'){
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
          value: '대댓글',
          child: Text('대댓글'),
        ),
        PopupMenuItem(
          value: '신고',
          child: Text('신고'),
        ),
      ];
    },
  );
}
