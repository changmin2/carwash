import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class SearchModel{
  final String lastBuildDate;
  final int total;
  final int start;
  final int display;
  final List<Item> items;

  SearchModel({
    required this.lastBuildDate,
    required this.total,
    required this.start,
    required this.display,
    required this.items
  });

  factory SearchModel.fromJson(Map<String,dynamic> json)
  => _$SearchModelFromJson(json);
}

@JsonSerializable()
class Item{
  final String title;
  final String link;
  final String image;
  final String lprice;
  final String hprice;
  final String mallName;
  final String productId;
  final String productType;
  final String brand;
  final String maker;
  final String category1;
  final String category2;
  final String category3;
  final String category4;

  Item({
    required this.title,
    required this.link,
    required this.image,
    required this.lprice,
    required this.hprice,
    required this.mallName,
    required this.productId,
    required this.productType,
    required this.brand,
    required this.maker,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4
  });

  factory Item.fromJson(Map<String,dynamic> json)
  => _$ItemFromJson(json);
}

