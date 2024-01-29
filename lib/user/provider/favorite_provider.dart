import 'package:carwash/user/repository/favorite_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider  = StateNotifierProvider<FavoriteStateNotifier,List<int>>((ref) {
  final repository = ref.watch(favoriteRepositoryProvider);

  final notifier = FavoriteStateNotifier(favoriteRepository:repository);

  return notifier;
});

class FavoriteStateNotifier extends StateNotifier<List<int>>{
  final FavoriteRepository favoriteRepository;

  FavoriteStateNotifier({
    required this.favoriteRepository
  }):super(
    []
  );

  Future<List<int>?> getFavorites() async{
    var pState = await favoriteRepository.getFavorites();

    if(pState!=null){
      state = pState;
    }

  }


}