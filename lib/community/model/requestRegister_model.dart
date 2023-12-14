import 'package:json_annotation/json_annotation.dart';

part 'requestRegister_model.g.dart';

@JsonSerializable()
class RequestRegisterParam{
  final String creator;
  final String content;
  final String title;
  final String category;

  RequestRegisterParam({
    required this.creator,
    required this.content,
    required this.title,
    required this.category
  });

  factory RequestRegisterParam.fromJson(Map<String,dynamic> json)
  => _$RequestRegisterParamFromJson(json);

  Map<String,dynamic> toJson() => _$RequestRegisterParamToJson(this);
}