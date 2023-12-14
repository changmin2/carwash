import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParams{
  final int? after;
  final int? count;
  final String? category;
  final int? id;

  const PaginationParams({
    this.after,
    this.count,
    this.category,
    this.id
  });

  PaginationParams copyWith({
    int? after,
    int? count,
    String? category,
    int? recipe_id,
  }){
    return PaginationParams(
        after: after ?? this.after,
        count: count ?? this.count,
        category: category ?? this.category,
        id: recipe_id ?? this.id
    );
  }

  factory PaginationParams.fromJson(Map<String,dynamic> json)
  => _$PaginationParamsFromJson(json);

  Map<String,dynamic> toJson() => _$PaginationParamsToJson(this);
}