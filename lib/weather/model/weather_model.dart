import 'package:carwash/common/component/weather.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel{
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherInfo> list;

  WeatherModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list
  });

  factory WeatherModel.fromJson(Map<String,dynamic> json)
  => _$WeatherModelFromJson(json);
}

@JsonSerializable()
class WeatherInfo{

  final WeatherMain main;

  WeatherInfo({
    required this.main
  });

  factory WeatherInfo.fromJson(Map<String,dynamic> json)
  => _$WeatherInfoFromJson(json);
}

@JsonSerializable()
class WeatherMain{
  final double temp;
  final double feels_like;
  final double temp_min;
  final double temp_max;

  WeatherMain({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max
  });

  factory WeatherMain.fromJson(Map<String,dynamic> json)
  => _$WeatherMainFromJson(json);
}