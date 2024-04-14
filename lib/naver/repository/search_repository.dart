import 'package:carwash/naver/model/search_model.dart';
import 'package:carwash/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;

part 'search_repository.g.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref){
  final dio = ref.watch(dioProvider);

  final repository = SearchRepository(dio,baseUrl: 'https://openapi.naver.com/v1/search/');

  return repository;
});

@RestApi()
abstract class SearchRepository{
  factory SearchRepository(Dio dio,{String baseUrl})
  = _SearchRepository;

  @GET("/shop.json")
  @Headers({
    'searchShopping' : 'true'
  })
  Future<SearchModel> searchProduct({
    @Query('query') required String item,
    @Query('start') int start = 1
  });
}