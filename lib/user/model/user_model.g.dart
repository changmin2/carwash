// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      username: json['username'] as String,
      password: json['password'] as String,
      nickname: json['nickname'] as String,
      intro: json['intro'] as String,
      firebaseToken: json['firebaseToken'] as String? ?? '',
      rcvAlarmYn: json['rcvAlarmYn'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'nickname': instance.nickname,
      'intro': instance.intro,
      'firebaseToken': instance.firebaseToken,
      'rcvAlarmYn': instance.rcvAlarmYn,
    };
