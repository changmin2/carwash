import 'package:json_annotation/json_annotation.dart';
import '../../common/model/model_with_id.dart';
import '../../common/model/model_with_idV2.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel implements IModelWithIdV2{
  final int comment_id;
  final int id;
  final String creator;
  final String content;
  final DateTime createDate;
  final List<Recomment>? commentList;

  CommentModel({
    required this.comment_id,
    required this.id,
    required this.creator,
    required this.content,
    required this.createDate,
    this.commentList
  });

  factory CommentModel.fromJson(Map<String,dynamic> json)
  => _$CommentModelFromJson(json);

  Map<String,dynamic> toJson() => _$CommentModelToJson(this);
}

//대댓글
@JsonSerializable()
class Recomment{
  final int recomment_id;
  final String creator;
  final String content;
  final DateTime createDate;
  final String target;

  Recomment({
    required this.recomment_id,
    required this.creator,
    required this.content,
    required this.createDate,
    required this.target
  });

  factory Recomment.fromJson(Map<String,dynamic> json)
  => _$RecommentFromJson(json);
}