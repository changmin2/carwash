// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberInfoDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoDto _$MemberInfoDtoFromJson(Map<String, dynamic> json) =>
    MemberInfoDto(
      record: json['record'] as String,
      myProdcuts:
          MyProductDto.fromJson(json['myProdcuts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberInfoDtoToJson(MemberInfoDto instance) =>
    <String, dynamic>{
      'record': instance.record,
      'myProdcuts': instance.myProdcuts,
    };
