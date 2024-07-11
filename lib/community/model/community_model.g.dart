// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) =>
    CommunityModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      creator: json['creator'] as String,
      hits: (json['hits'] as num).toInt(),
      favorite: (json['favorite'] as num).toInt(),
      category: json['category'] as String,
      createDate: json['createDate'] as String,
      hastag: json['hastag'] as String? ?? '',
      imgUrls: json['imgUrls'] as String? ?? '',
      commentCnt: (json['commentCnt'] as num).toInt(),
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
      'hastag': instance.hastag,
      'imgUrls': instance.imgUrls,
      'commentCnt': instance.commentCnt,
    };
