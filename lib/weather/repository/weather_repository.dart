import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

@RestApi()
abstract class WeatherRepository{
  factory WeatherRepository(Dio dio,{String baseUrl})
  = _WeatherRepository;

  @POST("")
  Future<void> readWeather(
    @Query('lat') int lat
  );


}