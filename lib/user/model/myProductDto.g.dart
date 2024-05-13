// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myProductDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProductDto _$MyProductDtoFromJson(Map<String, dynamic> json) => MyProductDto(
      productName: json['productName'] as String?,
      category: json['category'] as String?,
      cycle: json['cycle'] as String?,
      imgUrl: json['imgUrl'] as String?,
      link: json['link'] as String?,
      id: json['id'] as int?,
      memberId: json['memberId'] as String?,
    );

Map<String, dynamic> _$MyProductDtoToJson(MyProductDto instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'category': instance.category,
      'cycle': instance.cycle,
      'imgUrl': instance.imgUrl,
      'link': instance.link,
      'id': instance.id,
      'memberId': instance.memberId,
    };
