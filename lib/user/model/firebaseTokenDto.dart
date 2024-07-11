import 'package:json_annotation/json_annotation.dart';

part 'firebaseTokenDto.g.dart';

@JsonSerializable()
class FirebaseTokenDto{
  final String firebaseToken;

  FirebaseTokenDto({
    required this.firebaseToken
  });

  factory FirebaseTokenDto.fromJson(Map<String, dynamic> json)
  => _$FirebaseTokenDtoFromJson(json);

  Map<String, dynamic> toJson()
  => _$FirebaseTokenDtoToJson(this);
}