import 'package:json_annotation/json_annotation.dart';

part 'register_params.g.dart';

@JsonSerializable()
class RecordRegisterParams{
  final String? date;
  final String? place;
  final String? image;
  final List<dynamic>? washList;

  const RecordRegisterParams({
    this.date,
    this.place,
    this.image,
    this.washList
  });

  factory RecordRegisterParams.fromJson(Map<String,dynamic> json)
  => _$RecordRegisterParamsFromJson(json);

  Map<String,dynamic> toJson() => _$RecordRegisterParamsToJson(this);
}

