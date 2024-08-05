import 'package:carwash/user/model/edit_request.dart';
import 'package:carwash/user/model/firebaseTokenDto.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../model/duplicate_request.dart';
import '../model/join_request.dart';
import '../model/user_model.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return UserMeRepository(dio,baseUrl: 'http://$ip/members');
});

@RestApi()
abstract class UserMeRepository{
  factory UserMeRepository(Dio dio,{String baseUrl}) = _UserMeRepository;

  @GET('/me')
  @Headers({
    'accessToken':'true'
  })
  Future<UserModel> getMe();

  @POST('/duplicate')
  Future<bool> duplicate(
      @Body() DuplicateRequest duplicateRequest
  );

  @POST('/join')
  Future<String> join(
      @Body() JoinRequest joinRequest
  );

  @POST('/edit')
  @Headers({
    'accessToken':'true'
  })
  Future<String> edit(
      @Body() EditRequest editRequest
  );

  @POST('/setFirebaseToken')
  @Headers({
    'accessToken':'true'
  })
  Future<void> setFirebaseToken(
      @Body() FirebaseTokenDto firebaseTokenDto
  );

  @POST('/updateAlarmYn')
  @Headers({
    'accessToken':'true'
  })
  Future<void> updateAlarmYn();

}