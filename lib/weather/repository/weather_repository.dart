import 'package:carwash/weather/model/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/dio/dio.dart';

part 'weather_repository.g.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref){
  final dio = ref.watch(dioProvider);

  final repository = WeatherRepository(dio,baseUrl: 'http://api.openweathermap.org/data/2.5');

  return repository;
});

@RestApi()
abstract class WeatherRepository{
  factory WeatherRepository(Dio dio,{String baseUrl})
  = _WeatherRepository;

  @POST("/forecast")
  Future<WeatherModel> readWeather({
    @Query('lat') required double lat,
    @Query('lon') required double lon,
    @Query('appid') required String appid
  });

}