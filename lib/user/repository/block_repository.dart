import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

part 'block_repository.g.dart';

final blockRepositoryProvider = Provider<BlockRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return BlockRepository(dio,baseUrl: 'http://$ip/block');
});

@RestApi()
abstract class BlockRepository{

  factory BlockRepository(Dio dio,{String baseUrl}) = _BlockRepository;

  @GET('/addBlock/{blockId}')
  @Headers({
    'accessToken':'true'
  })
  Future<void> addBlock({
    @Path() required String blockId
  });

  @GET('/getBlock')
  @Headers({
    'accessToken':'true'
  })
  Future<List<String>> getBlock();

}