import 'package:json_annotation/json_annotation.dart';

part 'accountBookDto.g.dart';

@JsonSerializable()
class AccountBookDto {

  final DateTime date;
  final String category;
  final String title;
  final int cost;
  String? memo;

  AccountBookDto({
    required this.date,
    required this.category,
    required this.cost,
    required this.title,
    this.memo = ""
  });

  factory AccountBookDto.fromJson(Map<String, dynamic> json)
  => _$AccountBookDtoFromJson(json);

  Map<String, dynamic> toJson()
  => _$AccountBookDtoToJson(this);
}