// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myProductDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProductDto _$MyProductDtoFromJson(Map<String, dynamic> json) => MyProductDto(
      productName: json['productName'] as String?,
      category: json['category'] as String?,
      cycle: json['cycle'] as String?,
    );

Map<String, dynamic> _$MyProductDtoToJson(MyProductDto instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'category': instance.category,
      'cycle': instance.cycle,
    };
