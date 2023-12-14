// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) =>
    CommunityModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      creator: json['creator'] as String,
      hits: json['hits'] as int,
      favorite: json['favorite'] as int,
      category: json['category'] as String,
      createDate: json['createDate'] as String,
    );

Map<String, dynamic> _$CommunityModelToJson(CommunityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'creator': instance.creator,
      'hits': instance.hits,
      'favorite': instance.favorite,
      'category': instance.category,
      'createDate': instance.createDate,
    };
