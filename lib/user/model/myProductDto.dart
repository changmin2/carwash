import 'package:json_annotation/json_annotation.dart';

part 'myProductDto.g.dart';

@JsonSerializable()
class MyProductDto {

  final String? productName;
  final String? category;
  final String? cycle;
  final String? imgUrl;
  final String? link;
  final int? id;
  final String? memberId;


  const MyProductDto({
    this.productName,
    this.category,
    this.cycle,
    this.imgUrl,
    this.link,
    this.id,
    this.memberId
  });

  factory MyProductDto.fromJson(Map<String, dynamic> json)
  => _$MyProductDtoFromJson(json);

  Map<String, dynamic> toJson()
  => _$MyProductDtoToJson(this);
}