import 'package:json_annotation/json_annotation.dart';

import 'myProductDto.dart';

part 'memberInfoDto.g.dart';

@JsonSerializable()
class MemberInfoDto{
  final String record;
  final List<MyProductDto> myProduct;

  MemberInfoDto({
    required this.record,
    required this.myProduct
  });


  factory MemberInfoDto.fromJson(Map<String,dynamic> json)
  => _$MemberInfoDtoFromJson(json);
}
