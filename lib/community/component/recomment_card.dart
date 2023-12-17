import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../model/comment_model.dart';
import '../provider/comment_provider.dart';

class ReCommentCard extends ConsumerWidget {

  final Recomment recomment;
  final String username;
  final int comment_id;

  const ReCommentCard({
    required this.recomment,
    required this.username,
    required this.comment_id,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_flat,
                  size: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recomment.creator,
                        style: TextStyle(
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                          recomment.content
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                  recomment.createDate.toString().split(" ")[0]
              ),
            ),

          ]
      ),
    );
  }
}


PopupMenuButton _PopupMenuButtonPage (BuildContext context,WidgetRef ref,int recomment_id,int commnet_id){
  return PopupMenuButton(
    onSelected: (value){
      if(value=='신고') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('신고되었습니다. 누적된 신고자는 블라인드 처리 됩니다.'),
              duration: Duration(seconds: 1),
            )
        );
      }else if(value == '삭제'){
        ref.read(commentProvider(commnet_id).notifier).deleteReComment(recomment_id,commnet_id);
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


PopupMenuButton _NoCreatorPopupMenuButtonPage (BuildContext context,WidgetRef ref){
  return PopupMenuButton(
    onSelected: (value){
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
