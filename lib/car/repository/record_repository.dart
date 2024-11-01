import 'package:carwash/car/model/recentRecordDto.dart';
import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/car/model/register_params.dart';
import 'package:carwash/common/dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../common/const/data.dart';

part 'record_repository.g.dart';

final recordRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);

  final repository = RecordRepository(dio, baseUrl: 'http://$ip/car');

  return repository;
});

@RestApi()
abstract class RecordRepository {
  /// 이거는 무조건 이렇게 코딩한다.
  factory RecordRepository(Dio dio, {String baseUrl}) = _RecordRepository;

  @POST("/register")
  @Headers({'accessToken': 'true'})
  Future<recordDto> recordRegister({@Body() RecordRegisterParams? recordRegisterParams = const RecordRegisterParams()});

  @GET("/{date}")
  @Headers({'accessToken': 'true'})
  Future<List<recordDto>> getRecord({@Path() required String date});

  @POST("/recentRecord")
  Future<List<recordDto>> recentRecord({@Body() RecentRecordDto param = const RecentRecordDto()});

  @GET("/myrecord/register/{washList}")
  @Headers({'accessToken': 'true'})
  Future<void> registerMyRecord({@Path() required String washList});

  @GET("/myrecord")
  @Headers({'accessToken': 'true'})
  Future<String> getMyRecord();
}
