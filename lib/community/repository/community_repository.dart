import 'package:carwash/common/dio/dio.dart';
import 'package:carwash/common/repository/base_pagination_repository.dart';
import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/model/requestRegister_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';

part 'community_repository.g.dart';

final communityRepositoryProvider = Provider((ref) {
  final dio = ref.read(dioProvider);

  return CommunityRepository(dio,baseUrl: 'http://$ip/community');
});

@RestApi()
abstract class CommunityRepository extends IBasePaginationRepository<CommunityModel>{

  factory CommunityRepository(Dio dio,{String baseUrl})
  = _CommunityRepository;

  @GET('/communityPaginate')
  Future<CursorPagination<CommunityModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @POST('/register')
  Future<void> register(
    @Body() RequestRegisterParam param
  );

  @GET('/recentCommunity')
  Future<List<CommunityModel>> recentCommunity();

  @GET('/recentFreeCommunity')
  Future<List<CommunityModel>> recentFreeCommunity();


  @GET("/clickFavorite/{id}")
  Future<void> clickFavorite({
    @Path() required String id
  });

}