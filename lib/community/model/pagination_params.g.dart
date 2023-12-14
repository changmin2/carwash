// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      after: json['after'] as int?,
      count: json['count'] as int?,
      category: json['category'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) =>
    <String, dynamic>{
      'after': instance.after,
      'count': instance.count,
      'category': instance.category,
      'id': instance.id,
    };
