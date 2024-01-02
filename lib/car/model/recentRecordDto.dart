import 'package:json_annotation/json_annotation.dart';

part 'recentRecordDto.g.dart';

@JsonSerializable()
class RecentRecordDto {

  final String? memberId;

  const RecentRecordDto({
    this.memberId
  });

  factory RecentRecordDto.fromJson(Map<String, dynamic> json)
  => _$RecentRecordDtoFromJson(json);

  Map<String, dynamic> toJson()
  => _$RecentRecordDtoToJson(this);
}