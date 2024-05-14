import 'package:carwash/user/model/myProductDto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

part 'myProduct_repository.g.dart';

final myProductRepositoryProvider = Provider<MyProductRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return MyProductRepository(dio,baseUrl: 'http://$ip/members');
});

@RestApi()
abstract class MyProductRepository{

  factory MyProductRepository(Dio dio,{String baseUrl}) = _MyProductRepository;

  @POST("/registerMyProduct")
  @Headers({
    'accessToken':'true'
  })
  Future<MyProductDto> registerMyProduct({
    @Body() MyProductDto param = const MyProductDto()
  });

  @GET("/getMyProduct")
  @Headers({
    'accessToken':'true'
  })
  Future<List<MyProductDto>> getMyProduct();
}