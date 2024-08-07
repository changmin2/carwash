import 'package:json_annotation/json_annotation.dart';

part 'fcmMessageDto.g.dart';

@JsonSerializable()
class FcmMessageDto{
  final String title;
  final String body;
  final String? image;

  FcmMessageDto({
    required this.title,
    required this.body,
    this.image = ""
  });

  factory FcmMessageDto.fromJson(Map<String, dynamic> json)
  => _$FcmMessageDtoFromJson(json);

  Map<String, dynamic> toJson()
  => _$FcmMessageDtoToJson(this);
}