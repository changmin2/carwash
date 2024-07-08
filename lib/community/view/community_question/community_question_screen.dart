import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_question/widget/community_question_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/view/pagination_list_view.dart';
import '../../provider/communityProvider.dart';

class TCommunityQuestionScreen extends ConsumerWidget {
  const TCommunityQuestionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.watch(communityProvider);
    return Padding(
      padding: const EdgeInsets.all(TSizes.defalutSpace),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.read(communityProvider.notifier).paginate(
            forceRefetch: true,
          );
        },
        child: PaginationListView(
            provider: communityProvider,
            itemBuilder: <CommunityModel>(_,index,community){
              return TCommunityQuestionListWidget(
                model: community
              );
            }),
      ),
    );
  }
}
