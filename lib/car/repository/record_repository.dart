import 'package:carwash/car/model/register_params.dart';
import 'package:carwash/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../common/const/data.dart';

part 'record_repository.g.dart';

final recordRepositoryProvider = Provider((ref){
  final dio = ref.watch(dioProvider);
  
  final repository = RecordRepository(dio,baseUrl: 'http://$ip/car');

  return repository;
});

@RestApi()
abstract class RecordRepository{
  factory RecordRepository(Dio dio,{String baseUrl})
  = _RecordRepository;
  
  @POST("/register")
  @Headers({
    'accessToken':'true'
  })
  Future<void> recordRegister({
    @Body() RecordRegisterParams? recordRegisterParams = const RecordRegisterParams()
  });
}