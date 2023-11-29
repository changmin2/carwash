// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinRequest _$JoinRequestFromJson(Map<String, dynamic> json) => JoinRequest(
      memberId: json['memberId'] as String,
      password: json['password'] as String,
      nickname: json['nickname'] as String,
      intro: json['intro'] as String,
    );

Map<String, dynamic> _$JoinRequestToJson(JoinRequest instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'password': instance.password,
      'nickname': instance.nickname,
      'intro': instance.intro,
    };
