import 'package:json_annotation/json_annotation.dart';

part 'edit_request.g.dart';

@JsonSerializable()
class EditRequest{
  final String nickname;
  final String intro;

  EditRequest({
    required this.nickname,
    required this.intro
  });

  factory EditRequest.fromJson(Map<String, dynamic> json)
  => _$EditRequestFromJson(json);

  Map<String, dynamic> toJson()
  => _$EditRequestToJson(this);
}