import 'package:json_annotation/json_annotation.dart';

part 'recordDto.g.dart';

@JsonSerializable()
class recordDto{
  final int id;
  final String memberId;
  final String imgUrl;
  final String washList;
  final String place;
  final DateTime date;

  recordDto({
    required this.id,
    required this.memberId,
    required this.imgUrl,
    required this.washList,
    required this.place,
    required this.date
  });

  factory recordDto.fromJson(Map<String,dynamic> json)
  => _$recordDtoFromJson(json);

  Map<String,dynamic> toJson() => _$recordDtoToJson(this);
}