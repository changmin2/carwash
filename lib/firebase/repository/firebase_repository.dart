import 'package:carwash/firebase/model/fcmMessageDto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart' ;

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';

part 'firebase_repository.g.dart';

final firebaseRepositoryProvider = Provider<FirebaseRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return FirebaseRepository(dio,baseUrl: 'http://$ip/firebase');
});

@RestApi()
abstract class FirebaseRepository{
  factory FirebaseRepository(Dio dio,{String baseUrl}) = _FirebaseRepository;

  @POST('/fcm/sendTotalUser')
  @Headers({
    'accessToken':'true'
  })
  Future<void> sendTotalUser(
      @Body() FcmMessageDto fcmMessageDto
  );

}