import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/component/comment_card.dart';
import 'package:carwash/community/provider/comment_provider.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/component/pagination_list_viewV2.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';

class CommunityDetailScreenBak extends ConsumerStatefulWidget {
  static get routeName => 'communityDetailScreen';
  final id;
  const CommunityDetailScreenBak({
    required this.id,
    Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityDetailScreenBak> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends ConsumerState<CommunityDetailScreenBak> {



  @override
  Widget build(BuildContext context) {
    ref.invalidate(commentProvider);
    final state = ref.read(communityProvider.notifier).getDetail(widget.id);

    return DefaultLayoutV2(
      appBar: AppBar(
        title: Text(
          state.title
        ),
        actions:[
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: _commentRegisterButton(context, ref, widget.id)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Container(
              height: 400,
              child: SingleChildScrollView(
                  child: Text(
                    state.content
                  )
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(thickness: 1, height: 1,color: PRIMARY_COLOR),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '댓글',
              style: TextStyle(
                color: Colors.amber,
                fontSize: 25,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PaginationListViewV2(
                id: widget.id,
                provider: commentProvider(widget.id),
                itemBuilder: <Comment>(_,index,comment){
                  return CommentCard(
                      comment:comment,
                      recomments:comment.commentList,
                      board_id: widget.id
                  );
                }),
          ),
        ],
      )
    );
  }

}

TextButton _commentRegisterButton(BuildContext context,WidgetRef ref,int id){
  final _formKey = GlobalKey<FormState>();
  var _comment;

  return TextButton(
      onPressed: () async {
        await showModalBottomSheet(
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
                          onPressed: () async {
                            _formKey.currentState!.save();
                            if(_formKey.currentState!.validate()){
                              final state = await ref.watch(userMeProvider);
                              final pState = state as UserModel;
                              await ref.read(commentProvider(id).notifier).createComment(pState.username,_comment);
                              Navigator.pop(context);
                              await ref.read(communityProvider.notifier).upCommentCnt(id);

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
      },
      child: Text(
        '댓글작성',
        style: TextStyle(
            fontSize: 18
        ),
      )
  );
}