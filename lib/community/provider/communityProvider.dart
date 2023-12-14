import 'package:carwash/common/model/cursor_pagination_model.dart';
import 'package:carwash/common/provider/pagination_provider.dart';
import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final communityProvider = StateNotifierProvider<CommunityStateNotifier,CursorPaginationBase>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  String category = '';

  return CommunityStateNotifier(repository: repository, category: category);
});

class CommunityStateNotifier extends PaginationProvider<CommunityModel,CommunityRepository>{

  CommunityStateNotifier({
    required super.repository,
    required super.category
  });

  void init(){
    state is CursorPaginationLoading;
  }

}