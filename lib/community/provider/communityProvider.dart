import 'package:carwash/common/model/cursor_pagination_model.dart';
import 'package:carwash/common/provider/pagination_provider.dart';
import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/provider/category_provider.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


final communityProvider = StateNotifierProvider<CommunityStateNotifier,CursorPaginationBase>((ref) {
  final category = ref.watch(categoryProvider);
  final repository = ref.watch(communityRepositoryProvider);
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

  CommunityModel getDetail(int id){

    final pState = state as CursorPagination;

    return pState.data.where((e) => e.id == id).first;
  }

  void clickFavorite(int id){

    var pState = state as CursorPagination;
    List<CommunityModel> tempList = [];
    for(int i =0; i<pState.data.length; i++){
      if(pState.data[i].id == id){
        pState.data[i].favorite+=1;
        tempList.add(pState.data[i]);
      }else{
        tempList.add(pState.data[i]);
      }
    }
    repository.clickFavorite(id: id.toString());
    state = pState.copyWith(
      data: tempList
    );
  }


}