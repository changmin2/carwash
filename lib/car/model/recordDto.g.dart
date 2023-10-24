// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recordDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

recordDto _$recordDtoFromJson(Map<String, dynamic> json) => recordDto(
      id: json['id'] as int,
      memberId: json['memberId'] as String,
      imgUrl: json['imgUrl'] as String,
      washList: json['washList'] as String,
      place: json['place'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$recordDtoToJson(recordDto instance) => <String, dynamic>{
      'id': instance.id,
      'memberId': instance.memberId,
      'imgUrl': instance.imgUrl,
      'washList': instance.washList,
      'place': instance.place,
      'date': instance.date.toIso8601String(),
    };
