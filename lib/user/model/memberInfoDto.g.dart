// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberInfoDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfoDto _$MemberInfoDtoFromJson(Map<String, dynamic> json) =>
    MemberInfoDto(
      record: json['record'] as String,
      myProduct: (json['myProduct'] as List<dynamic>)
          .map((e) => MyProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemberInfoDtoToJson(MemberInfoDto instance) =>
    <String, dynamic>{
      'record': instance.record,
      'myProduct': instance.myProduct,
    };
