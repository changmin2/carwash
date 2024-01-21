import 'package:carwash/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_model.g.dart';

@JsonSerializable()
class CommunityModel implements IModelWithId{
  final int id;
  final String title;
  final String content;
  final String creator;
  final int hits;
  int favorite;
  final String category;
  final String createDate;
  String? hastag;
  String? imgUrls;
  int commentCnt;


  set favor(int num){
    this.favorite+=num;
  }

  CommunityModel({
    required this.id,
    required this.title,
    required this.content,
    required this.creator,
    required this.hits,
    required this.favorite,
    required this.category,
    required this.createDate,
    this.hastag = '',
    this.imgUrls = '',
    required this.commentCnt
  });

  factory CommunityModel.fromJson(Map<String,dynamic> json)
  => _$CommunityModelFromJson(json);

  Map<String,dynamic> toJson() => _$CommunityModelToJson(this);
}