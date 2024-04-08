import 'package:json_annotation/json_annotation.dart';

part 'weatherView_model.g.dart';

@JsonSerializable()
class WeatherViewModel{
  final double temp_min;
  final double temp_max;
  final String dt_txt;
  final String m_weather;
  final String a_weather;
  final int humidity;


  WeatherViewModel({
    required this.temp_min,
    required this.temp_max,
    required this.dt_txt,
    required this.m_weather,
    required this.a_weather,
    required this.humidity
  });

  factory WeatherViewModel.fromJson(Map<String,dynamic> json)
  => _$WeatherViewModelFromJson(json);
}
