import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

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

  Future<void> getHotAll() async{
    if(state.length == 0){
      var resp = await repository.recentCommunity();
      state = resp;
    }

  }

  CommunityModel? getModelById(int id){
    var pState = state;
    for(int i = 0; i<pState.length; i++){
      if(pState[i].id == id){
        return pState[i];
      }
    }
    return null;
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

  void downFavorite(int id){

    var pState = state;
    List<CommunityModel> tempList = [];
    for(int i =0; i<pState.length; i++){
      if(pState[i].id == id){
        pState[i].favorite-=1;
        tempList.add(pState[i]);
      }else{
        tempList.add(pState[i]);
      }
    }
    repository.downFavorite(id: id.toString());
    state = tempList;
  }

  Future<void> upCommentCnt(int id)async {
    var pState = state;
    List<CommunityModel> tempList = [];
    for(int i =0; i<pState.length; i++){
      if(pState[i].id == id){
        pState[i].commentCnt+=1;
        tempList.add(pState[i]);
      }else{
        tempList.add(pState[i]);
      }
    }

    state =tempList;
  }

  Future<void> downCommentCnt(int id,int count)async {

    var pState = state;
    List<CommunityModel> tempList = [];
    for(int i =0; i<pState.length; i++){
      if(pState[i].id == id){
        pState[i].commentCnt-=count;
        tempList.add(pState[i]);
      }else{
        tempList.add(pState[i]);
      }
    }

    state  = tempList;
  }

  Future<void> deleteBoard(int id) async {

    await repository.deleteBoard(id: id.toString());

  }

}