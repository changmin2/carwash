import 'package:json_annotation/json_annotation.dart';

import 'myProductDto.dart';

part 'memberInfoDto.g.dart';

@JsonSerializable()
class MemberInfoDto{
  final String record;
  final MyProductDto myProdcuts;

  MemberInfoDto({
    required this.record,
    required this.myProdcuts
  });


  factory MemberInfoDto.fromJson(Map<String,dynamic> json)
  => _$MemberInfoDtoFromJson(json);
}
