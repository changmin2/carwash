import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase{}

class UserModelError extends UserModelBase{
  final String message;

  UserModelError({
    required this.message
  });
}

class UserModelLoading extends UserModelBase{}

@JsonSerializable()
class UserModel extends UserModelBase{
  final String username;
  final String password;
  final String nickname;
  final String intro;

  UserModel({
    required this.username,
    required this.password,
    required this.nickname,
    required this.intro
  });


  factory UserModel.fromJson(Map<String,dynamic> json)
  => _$UserModelFromJson(json);


  Map<String, dynamic> toJson()
  => _$UserModelToJson(this);
}