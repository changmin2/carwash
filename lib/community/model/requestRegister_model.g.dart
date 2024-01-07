// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestRegister_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestRegisterParam _$RequestRegisterParamFromJson(
        Map<String, dynamic> json) =>
    RequestRegisterParam(
      creator: json['creator'] as String,
      content: json['content'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      hastag: json['hastag'] as String,
      imgUrl: json['imgUrl'] as String? ?? '',
    );

Map<String, dynamic> _$RequestRegisterParamToJson(
        RequestRegisterParam instance) =>
    <String, dynamic>{
      'creator': instance.creator,
      'content': instance.content,
      'title': instance.title,
      'category': instance.category,
      'hastag': instance.hastag,
      'imgUrl': instance.imgUrl,
    };
