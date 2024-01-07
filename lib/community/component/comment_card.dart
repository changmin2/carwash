import 'package:carwash/community/component/recomment_card.dart';
import 'package:carwash/community/model/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/sizes.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../provider/comment_provider.dart';

class CommentCard extends ConsumerWidget {
  final CommentModel comment;
  final List<Recomment>? recomments;
  final int board_id;
  const CommentCard({
    required this.comment,
    required this.recomments,
    required this.board_id,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final user = ref.read(userMeProvider) as UserModel;
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
                      _PopupMenuButtonPage(context, ref, comment.comment_id, board_id)
                          :_NoCreatorPopupMenuButtonPage(context, ref, comment.comment_id, board_id)
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
                        );
                      }): Container(),
          const SizedBox(height: TSizes.spaceBtwItems),
        ],
      )
    );
  }
}

PopupMenuButton _PopupMenuButtonPage (BuildContext context,WidgetRef ref,int comment_id,int board_id){
  return PopupMenuButton(
    onSelected: (value) async {
      if(value=='삭제') {
        if(context.mounted){
          await ref.read(commentProvider(board_id).notifier).deleteComment(comment_id);
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
        final _formKey = GlobalKey<FormState>();
        var _comment;
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context){
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (value){
                          _comment = value as String;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '댓글을 입력해주세요'
                        ),
                        validator: (value){
                          if(value!.length<1){
                            return "댓글을 입력해주세요";
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            _formKey.currentState!.save();
                            if(_formKey.currentState!.validate()){
                              final state = ref.watch(userMeProvider);
                              final pState = state as UserModel;
                              ref.read(commentProvider(board_id).notifier).createRecommend(pState.username,_comment, comment_id);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('등록'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text('취소'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
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
        PopupMenuItem(
          value: '삭제',
          child: Text('삭제'),
        )
      ];
    },
  );
}


PopupMenuButton _NoCreatorPopupMenuButtonPage (BuildContext context,WidgetRef ref,int comment_id,int recipe_id){
  return PopupMenuButton(
    onSelected: (value){
      if(value=='대댓글'){
        final _formKey = GlobalKey<FormState>();
        var _comment;
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context){
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        onSaved: (value){
                          _comment = value as String;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '댓글을 입력해주세요'
                        ),
                        validator: (value){
                          if(value!.length<1){
                            return "댓글을 입력해주세요";
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            _formKey.currentState!.save();
                            if(_formKey.currentState!.validate()){
                              final state = ref.watch(userMeProvider);
                              final pState = state as UserModel;
                              ref.read(commentProvider(recipe_id).notifier).createRecommend(pState.username,_comment, comment_id);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('등록'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text('취소'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
        );

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
