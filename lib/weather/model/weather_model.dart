import 'package:carwash/common/component/weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel{
  final String cod;
  final int message;
  final int cnt;

  WeatherModel({
    required this.cod,
    required this.message,
    required this.cnt
  });

  factory WeatherModel.fromJson(Map<String,dynamic> json)
  => _$WeatherModelFromJson(json);
}