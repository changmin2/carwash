import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/component/comment_register_screen.dart';
import 'package:carwash/community/component/recomment_card.dart';
import 'package:carwash/community/model/comment_model.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.read(userMeProvider) as UserModel;
    int recommentsCnt = recomments == null ? 1 : recomments!.length + 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 유저 사진
        const TRoundedImage(
          imageUrl: 'asset/img/profile_image.png',
          borderRadius: 100,
          width: 30,
          height: 30,
        ),

        const SizedBox(width: TSizes.spaceBtwItems / 2),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 유저 닉네임
              SizedBox(
                width: THelperFunctions.screenWidth(context) * 0.7,
                child: Text(
                  comment.creator,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: TSizes.xs),

              /// 댓글내용
              Text(
                comment.content.trim(),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: TSizes.xs),

              Row(
                children: [
                  /// 날짜
                  Text(
                    comment.createDate.toString().split(" ")[0],
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(width: TSizes.xs),

                  Text(
                    "·",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(width: TSizes.xs),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)
                         => CommentRegisterScreen(
                           id: board_id,
                           comment_id: comment.comment_id,
                           flag: flag,
                           creator: comment.creator,
                         ),
                        )
                      );
                    },
                    child: Text(
                      "답글달기",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                    ),
                  ),

                  const SizedBox(width: TSizes.xs),

                  Text(
                    "·",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(width: TSizes.xs),

                  GestureDetector(
                    onTap: () => THelperFunctions.showSnackBar(context, '신고되었습니다. 검토까지는 최대 24시간 소요되며 신고가 누적된 사용자는 글을 작성할 수 없게 됩니다.'),
                    child: Text(
                      "신고하기",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                    ),
                  ),

                  (comment.creator == user.nickname || user.nickname == '관리자')
                      ? Row(
                          children: [
                            const SizedBox(width: TSizes.xs),
                            Text(
                              "·",
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(width: TSizes.xs),

                            GestureDetector(
                              onTap: () async {
                                if (context.mounted) {
                                  await ref.read(commentProvider(board_id).notifier).deleteComment(comment.comment_id);
                                  flag == 0
                                      ? ref.read(communityProvider.notifier).downCommentCnt(board_id, recommentsCnt)
                                      : flag == 1
                                          ? ref.read(hotAllCommunityProvider.notifier).downCommentCnt(board_id, recommentsCnt)
                                          : ref.read(hotFreeCommunityProvider.notifier).downCommentCnt(board_id, recommentsCnt);

                                  THelperFunctions.showSnackBar(context, "댓글 삭제 성공");
                                }
                              },
                              child: Text(
                                "삭제",
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 대댓글 내용
              recomments!.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recomments!.length,
                      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
                      itemBuilder: (BuildContext context, int index) {
                        return ReCommentCard(
                          board_id: board_id,
                          recomment: recomments![index],
                          username: comment.creator,
                          comment_id: comment.comment_id,
                          flag: flag,
                        );
                      })
                  : Container(),
              // const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}

// PopupMenuButton _PopupMenuButtonPage(BuildContext context, WidgetRef ref, int comment_id, int board_id, int recommentsCnt, flag) {
//   return PopupMenuButton(
//     onSelected: (value) async {
//       if (value == '삭제') {
//         if (context.mounted) {
//           await ref.read(commentProvider(board_id).notifier).deleteComment(comment_id);
//           await flag == 0
//               ? ref.read(communityProvider.notifier).downCommentCnt(board_id, recommentsCnt)
//               : flag == 1
//                   ? ref.read(hotAllCommunityProvider.notifier).downCommentCnt(board_id, recommentsCnt)
//                   : ref.read(hotFreeCommunityProvider.notifier).downCommentCnt(board_id, recommentsCnt);
//         }
//         //댓글 밑에 달린 대댓글 갯수를 가져오지 않고 다시 업데이트
//       } else if (value == '신고') {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('신고되었습니다. 검토까지는 최대 24시간 소요되며 신고가 누적된 사용자는 글을 작성할 수 없게 됩니다.'),
//           duration: Duration(seconds: 1),
//         ));
//       } else if (value == '대댓글') {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CommentRegisterScreen(
//                       id: board_id,
//                       comment_id: comment_id,
//                       flag: flag,
//                     )));
//       }
//     },
//     itemBuilder: (context) {
//       return [
//         PopupMenuItem(
//           value: '대댓글',
//           child: Text('대댓글'),
//         ),
//         PopupMenuItem(
//           value: '신고',
//           child: Text('신고'),
//         ),
//         PopupMenuItem(
//           value: '삭제',
//           child: Text('삭제'),
//         )
//       ];
//     },
//   );
// }
//
// PopupMenuButton _NoCreatorPopupMenuButtonPage(BuildContext context, WidgetRef ref, int comment_id, int recipe_id, int flag) {
//   return PopupMenuButton(
//     onSelected: (value) {
//       if (value == '대댓글') {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CommentRegisterScreen(
//                       id: recipe_id,
//                       comment_id: comment_id,
//                       flag: flag,
//                     )));
//       } else if (value == '신고') {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('신고되었습니다. 검토까지는 최대 24시간 소요되며 신고가 누적된 사용자는 글을 작성할 수 없게 됩니다.'),
//           duration: Duration(seconds: 1),
//         ));
//       }
//     },
//     itemBuilder: (context) {
//       return [
//         PopupMenuItem(
//           value: '대댓글',
//           child: Text('대댓글'),
//         ),
//         PopupMenuItem(
//           value: '신고',
//           child: Text('신고'),
//         ),
//       ];
//     },
//   );
// }
