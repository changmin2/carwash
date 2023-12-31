import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hotAllCommunityProvider = StateNotifierProvider<HotAllCommunityNotifier,List<CommunityModel>>((ref) {
  final repository = ref.watch(communityRepositoryProvider);
  return HotAllCommunityNotifier(repository);
});

class HotAllCommunityNotifier extends StateNotifier<List<CommunityModel>>{
  final CommunityRepository repository;
  HotAllCommunityNotifier(this.repository): super(
    []
  ){
    getHotAll();
  }

  void getHotAll() async{
    var resp = await repository.recentCommunity();
    state = resp;
  }

  void clickFavorite(int id){

    var pState = state;
    List<CommunityModel> tempList = [];
    for(int i =0; i<pState.length; i++){
      if(pState[i].id == id){
        pState[i].favorite+=1;
        tempList.add(pState[i]);
      }else{
        tempList.add(pState[i]);
      }
    }
    repository.clickFavorite(id: id.toString());
    state = tempList;
  }
}