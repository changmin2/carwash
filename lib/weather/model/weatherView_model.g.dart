// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weatherView_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherViewModel _$WeatherViewModelFromJson(Map<String, dynamic> json) =>
    WeatherViewModel(
      temp_min: (json['temp_min'] as num).toDouble(),
      temp_max: (json['temp_max'] as num).toDouble(),
      dt_txt: json['dt_txt'] as String,
      m_weather: json['m_weather'] as String,
      a_weather: json['a_weather'] as String,
      humidity: json['humidity'] as int,
      gu: json['gu'] as String? ?? "",
      si: json['si'] as String? ?? "",
    );

Map<String, dynamic> _$WeatherViewModelToJson(WeatherViewModel instance) =>
    <String, dynamic>{
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'dt_txt': instance.dt_txt,
      'm_weather': instance.m_weather,
      'a_weather': instance.a_weather,
      'humidity': instance.humidity,
      'gu': instance.gu,
      'si': instance.si,
    };
