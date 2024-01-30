import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

part 'favorite_repository.g.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return FavoriteRepository(dio,baseUrl: 'http://$ip/favorite');
});

@RestApi()
abstract class FavoriteRepository{

  factory FavoriteRepository(Dio dio,{String baseUrl}) = _FavoriteRepository;

  @GET('/')
  @Headers({
    'accessToken':'true'
  })
  Future<List<int>> getFavorites();

  @GET('/add/{id}')
  @Headers({
    'accessToken':'true'
  })
  Future<void> addFavorites({
    @Path() required int id
  });

  @GET('/delete/{id}')
  @Headers({
    'accessToken':'true'
  })
  Future<void> deleteFavorites({
    @Path() required int id
  });

}