// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountBookDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBookDto _$AccountBookDtoFromJson(Map<String, dynamic> json) =>
    AccountBookDto(
      id: (json['id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      category: json['category'] as String?,
      cost: (json['cost'] as num?)?.toInt(),
      title: json['title'] as String?,
      memo: json['memo'] as String? ?? "",
    );

Map<String, dynamic> _$AccountBookDtoToJson(AccountBookDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'category': instance.category,
      'title': instance.title,
      'cost': instance.cost,
      'memo': instance.memo,
    };
