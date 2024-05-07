import 'package:carwash/user/model/myProductDto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../car/model/recentRecordDto.dart';
import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

part 'myProduct_repository.g.dart';

final myProductRepositoryProvider = Provider<MyProductRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return MyProductRepository(dio,baseUrl: 'http://$ip/car');
});

@RestApi()
abstract class MyProductRepository{

  factory MyProductRepository(Dio dio,{String baseUrl}) = _MyProductRepository;

  @POST("/registerMyProduct")
  Future<void> registerMyProduct({
    @Body() MyProductDto param = const MyProductDto()
  });
}