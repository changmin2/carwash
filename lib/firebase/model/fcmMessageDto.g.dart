// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcmMessageDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmMessageDto _$FcmMessageDtoFromJson(Map<String, dynamic> json) =>
    FcmMessageDto(
      title: json['title'] as String,
      body: json['body'] as String,
      image: json['image'] as String? ?? "",
    );

Map<String, dynamic> _$FcmMessageDtoToJson(FcmMessageDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'image': instance.image,
    };
