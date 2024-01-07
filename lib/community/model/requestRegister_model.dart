import 'package:json_annotation/json_annotation.dart';

part 'requestRegister_model.g.dart';

@JsonSerializable()
class RequestRegisterParam{
  final String creator;
  final String content;
  final String title;
  final String category;
  final String hastag;
  String? imgUrl;

  RequestRegisterParam({
    required this.creator,
    required this.content,
    required this.title,
    required this.category,
    required this.hastag,
    this.imgUrl = ''
  });

  factory RequestRegisterParam.fromJson(Map<String,dynamic> json)
  => _$RequestRegisterParamFromJson(json);

  Map<String,dynamic> toJson() => _$RequestRegisterParamToJson(this);
}