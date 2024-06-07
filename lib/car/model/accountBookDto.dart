import 'package:json_annotation/json_annotation.dart';

part 'accountBookDto.g.dart';

@JsonSerializable()
class AccountBookDto {

  final int? id;
  final DateTime? date;
  final String? category;
  final String? title;
  final int? cost;
  final String? memo;

  const AccountBookDto({
    this.id,
    this.date,
    this.category,
    this.cost,
    this.title,
    this.memo = ""
  });


  factory AccountBookDto.fromJson(Map<String, dynamic> json)
  => _$AccountBookDtoFromJson(json);

  Map<String, dynamic> toJson()
  => _$AccountBookDtoToJson(this);
}