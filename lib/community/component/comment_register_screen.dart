import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:carwash/community/provider/hot_all_community_provider.dart';
import 'package:carwash/community/provider/hot_free_community_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/const/colors.dart';
import '../../common/const/sizes.dart';
import '../../user/model/user_model.dart';
import '../../user/provider/user_me_provider.dart';
import '../provider/comment_provider.dart';

class CommentRegisterScreen extends ConsumerWidget {
  final int id;
  int? comment_id;
  int? flag; // 0: 일반 게시판,
  CommentRegisterScreen({
    required this.id,
    this.comment_id = -1,
    this.flag = 0,
    Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  var _content;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return DefaultLayoutV2(
      child: TRoundedContainer(
        height: THelperFunctions.screenHeight(context),
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  onChanged: (value) {
                    _content = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "내용을 입력해주세요.";
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: '부적절하거나 불쾌감을 줄 수 있는 컨텐츠는 제재를 받을 수 있습니다.',
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                ),
              ),
            ),

            const SizedBox(width: TSizes.spaceBtwItems),

            /// 댓글 등록
            GestureDetector(
              onTap: () async {

                _formKey.currentState!.save();
                if (_formKey.currentState!.validate()) {
                  //일반 댓글 등록
                  if(comment_id == -1){
                    final state = ref.watch(userMeProvider);
                    final pState = state as UserModel;

                    await ref.read(commentProvider(id).notifier)
                        .createComment(pState.nickname, _content);
                    await flag == 0 ? ref.read(communityProvider.notifier).upCommentCnt(id)
                        : flag == 1 ? ref.read(hotAllCommunityProvider.notifier).upCommentCnt(id): ref.read(hotFreeCommunityProvider.notifier).upCommentCnt(id);

                  }
                  //대댓글
                  else{

                    final state = ref.watch(userMeProvider);
                    final pState = state as UserModel;
                    await ref.read(commentProvider(id).notifier).createRecommend(pState.nickname,_content, comment_id!);
                    await flag == 0 ? ref.read(communityProvider.notifier).upCommentCnt(id)
                        : flag == 1 ? ref.read(hotAllCommunityProvider.notifier).upCommentCnt(id): ref.read(hotFreeCommunityProvider.notifier).upCommentCnt(id);

                  }

                  Navigator.pop(context);
                }
              },
              child: const Icon(
                Iconsax.edit,
                size: 35,
                color: PRIMARY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
