// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
      lastBuildDate: json['lastBuildDate'] as String,
      total: (json['total'] as num).toInt(),
      start: (json['start'] as num).toInt(),
      display: (json['display'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'lastBuildDate': instance.lastBuildDate,
      'total': instance.total,
      'start': instance.start,
      'display': instance.display,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      title: json['title'] as String,
      link: json['link'] as String,
      image: json['image'] as String,
      lprice: json['lprice'] as String,
      hprice: json['hprice'] as String,
      mallName: json['mallName'] as String,
      productId: json['productId'] as String,
      productType: json['productType'] as String,
      brand: json['brand'] as String,
      maker: json['maker'] as String,
      category1: json['category1'] as String,
      category2: json['category2'] as String,
      category3: json['category3'] as String,
      category4: json['category4'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
      'lprice': instance.lprice,
      'hprice': instance.hprice,
      'mallName': instance.mallName,
      'productId': instance.productId,
      'productType': instance.productType,
      'brand': instance.brand,
      'maker': instance.maker,
      'category1': instance.category1,
      'category2': instance.category2,
      'category3': instance.category3,
      'category4': instance.category4,
    };
