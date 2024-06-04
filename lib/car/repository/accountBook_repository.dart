import 'package:carwash/car/model/accountBookDto.dart';
import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../common/const/data.dart';

part 'accountBook_repository.g.dart';

final accountBookRepositoryProvider = Provider((ref){
  final dio = ref.watch(dioProvider);

  final repository = AccountBookRepository(dio,baseUrl: 'http://$ip/accountBook');

  return repository;
});

@RestApi()
abstract class AccountBookRepository{
  factory AccountBookRepository(Dio dio,{String baseUrl})
  = _AccountBookRepository;

  @POST("/add")
  @Headers({
    'accessToken':'true'
  })
  Future<AccountBookDto> addAccountBook({
    @Body() AccountBookDto param = const AccountBookDto()
  });

  @GET("/getAccountBooks")
  @Headers({
    'accessToken':'true'
  })
  Future<List<AccountBookDto>> getAccountBooks();

  @GET("/deleteAccountBooks/{id}")
  Future<void> deleteAccountBooks({
    @Path() required int id
  });
}