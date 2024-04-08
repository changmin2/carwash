import 'dart:ffi';
import 'dart:math';

import 'package:carwash/common/component/weather.dart';
import 'package:carwash/common/const/data.dart';
import 'package:carwash/weather/model/weatherView_model.dart';
import 'package:carwash/weather/model/weather_model.dart';
import 'package:carwash/weather/repository/weather_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

final WeatherProvider = StateNotifierProvider<WeatherStateNotifier,List<WeatherViewModel>>(
        (ref) {
          final repository = ref.watch(weatherRepositoryProvider);

          final notifier = WeatherStateNotifier(repository: repository);

          return notifier;
        }
);

class WeatherStateNotifier extends StateNotifier<List<WeatherViewModel>>{

  final WeatherRepository repository;

  WeatherStateNotifier({
    required this.repository
  })
  : super(
    []
  );


  Future<void> getWeather()async {
    if(state.length!=0){
      return;
    }else{
      var times = ['09','12','24'];

      Position position;
      Position? lastPosition = await Geolocator.getLastKnownPosition();


      if(lastPosition != null){

        position = lastPosition;
      }else{
        position =  await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
      }

      var pstate = await repository.readWeather(lat: position.latitude,
          lon: position.longitude,
          appid: openWeatherApiKey);
      List<WeatherViewModel> weatherViewModel = [];

      var  temp_min;
      var  temp_max;
      var  dt_txt;
      var  m_weather;
      var  a_weather;
      var humidity;
      var init = 0;
      var idx = 0;
      for (var o in pstate.list) {
        idx+=1; //humidity 평균을 구하기 위한 변수
        //00시 일 때 새로운 WeatherViewModel 생성
        if(init==0){
          init+=1;
          humidity = o.main.humidity;
          temp_min = o.main.temp_min;
          temp_max = o.main.temp_max;
          dt_txt = o.dt_txt;
          m_weather = o.weather[0].main;
          a_weather = o.weather[0].main;
        }else{
          humidity += o.main.humidity;
          if(temp_min > o.main.temp_min){
            temp_min = o.main.temp_min;
          }

          if(temp_max < o.main.temp_max){
            temp_max = o.main.temp_max;
          }

          a_weather = o.weather[0].main;

        }
        //마지막 시간인 21시가 되면 날씨 모델 추가
        if(o.dt_txt.split(" ")[1].split(":")[0] == '21'){
          init = 0;

          var hu = (humidity/idx).toInt();
          WeatherViewModel model = new WeatherViewModel(temp_min: temp_min, temp_max: temp_max, dt_txt: dt_txt,
              m_weather: m_weather, a_weather: a_weather,humidity: hu);

          idx = 0;
          weatherViewModel.add(model);
        }

      }
      state = weatherViewModel;
    }

  }
}