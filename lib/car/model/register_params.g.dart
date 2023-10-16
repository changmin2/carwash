// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordRegisterParams _$RecordRegisterParamsFromJson(
        Map<String, dynamic> json) =>
    RecordRegisterParams(
      date: json['date'] as String?,
      place: json['place'] as String?,
      image: json['image'] as String?,
      washList: json['washList'] as List<dynamic>?,
    );

Map<String, dynamic> _$RecordRegisterParamsToJson(
        RecordRegisterParams instance) =>
    <String, dynamic>{
      'date': instance.date,
      'place': instance.place,
      'image': instance.image,
      'washList': instance.washList,
    };
