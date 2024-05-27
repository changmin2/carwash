// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accountBookDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBookDto _$AccountBookDtoFromJson(Map<String, dynamic> json) =>
    AccountBookDto(
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      cost: json['cost'] as int,
      title: json['title'] as String,
      memo: json['memo'] as String? ?? "",
    );

Map<String, dynamic> _$AccountBookDtoToJson(AccountBookDto instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'title': instance.title,
      'cost': instance.cost,
      'memo': instance.memo,
    };
