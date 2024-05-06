import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
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
import 'comment_register_screen.dart';

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
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(commentProvider(board_id));
    final user = ref.read(userMeProvider) as UserModel;
    return TRoundedContainer(

      padding: const EdgeInsets.all(TSizes.sm),
      backgroundColor: Colors.grey.shade100,
      child: Row(
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 유저 닉네임
              SizedBox(
                width: THelperFunctions.screenWidth(context) * 0.6,
                child: Text(
                  recomment.creator,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: TSizes.xs),

              SizedBox(
                // 전체 가로 길이 - (양쪽 padding 값 * 2) - (유저사진 * 2) - (유저사진 옆 padding * 2) - (대댓글 컨테이너 padding * 2)
                width: THelperFunctions.screenWidth(context) - (TSizes.defalutSpace * 2) - (30 * 2) - (TSizes.spaceBtwItems / 2 * 2) - (TSizes.sm * 2),
                child: Text.rich(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '@'+recomment.target+' ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: PRIMARY_COLOR),
                      ),
                      TextSpan(
                        text: recomment.content.trim(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: TSizes.xs),

              Row(
                children: [
                  /// 날짜
                  Text(
                    recomment.createDate.toString().split(" ")[0],
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(width: TSizes.xs),

                  Text(
                    "·",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                  ),

                  const SizedBox(width: TSizes.xs),

                  GestureDetector(
                    onTap: () => THelperFunctions.navigateToScreen(
                      context,
                      CommentRegisterScreen(
                        id: board_id,
                        comment_id: comment_id,
                        flag: flag,
                        creator: recomment.creator,
                      ),
                    ),
                    child: Text(
                      "답글달기",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.grey),
                    ),
                  ),
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

                  (recomment.creator == user.nickname || user.nickname == '관리자')
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
                                await ref.read(commentProvider(board_id).notifier).deleteReComment(recomment.recomment_id, comment_id);
                                flag == 0
                                    ? ref.read(communityProvider.notifier).downCommentCnt(board_id, 1)
                                    : flag == 1
                                        ? ref.read(hotAllCommunityProvider.notifier).downCommentCnt(board_id, 1)
                                        : ref.read(hotFreeCommunityProvider.notifier).downCommentCnt(board_id, 1);

                                THelperFunctions.showSnackBar(context, "댓글 삭제 성공");
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
            ],
          ),
        ],
      ),
    );
  }
}
