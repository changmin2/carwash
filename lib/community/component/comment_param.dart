import 'package:json_annotation/json_annotation.dart';

part 'comment_param.g.dart';

@JsonSerializable()
class CommentParam{
  final String? creator;
  final String? content;
  final String? target;

  const CommentParam({
    this.creator,
    this.content,
    this.target = ''
  });

  factory CommentParam.fromJson(Map<String,dynamic> json)
  => _$CommentParamFromJson(json);

  Map<String,dynamic> toJson() => _$CommentParamToJson(this);
}