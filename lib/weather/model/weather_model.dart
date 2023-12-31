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

  WeatherModel copyWith({
    List<WeatherInfo>? list
  }){
    return WeatherModel(
      cod: this.cod,
      message: this.message,
      cnt: this.cnt,
      list:  list ?? this.list
    );
  }

  factory WeatherModel.fromJson(Map<String,dynamic> json)
  => _$WeatherModelFromJson(json);
}

@JsonSerializable()
class WeatherInfo{

  final WeatherMain main;
  final List<Cloud> weather;
  final String dt_txt;

  WeatherInfo({
    required this.main,
    required this.weather,
    required this.dt_txt
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
  final int humidity;

  WeatherMain({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.humidity
  });

  factory WeatherMain.fromJson(Map<String,dynamic> json)
  => _$WeatherMainFromJson(json);
}

@JsonSerializable()
class Cloud{
  final String main;

  Cloud({
    required this.main
  });

  factory Cloud.fromJson(Map<String,dynamic> json)
  => _$CloudFromJson(json);
}