import 'package:carwash/common/component/weather.dart';
import 'package:carwash/common/const/data.dart';
import 'package:carwash/weather/model/weather_model.dart';
import 'package:carwash/weather/repository/weather_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final WeatherProvider = StateNotifierProvider<WeatherStateNotifier,List<WeatherModel>>(
        (ref) {
          final repository = ref.watch(weatherRepositoryProvider);

          final notifier = WeatherStateNotifier(repository: repository);

          return notifier;
        }
);

class WeatherStateNotifier extends StateNotifier<List<WeatherModel>>{

  final WeatherRepository repository;

  WeatherStateNotifier({
    required this.repository
  })
  : super(
    []
  );


  Future<void> getWeather()async {
    var times = ['09','12','18'];
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var pstate = await repository.readWeather(lat: position.latitude,
        lon: position.longitude,
        appid: openWeatherApiKey);
    pstate = pstate.copyWith(
      list: pstate.list.where((e) => times.contains(e.dt_txt.split(" ")[1].split(":")[0])).toList()
    );
    state = [pstate as WeatherModel];
  }
}