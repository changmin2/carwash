import 'package:carwash/weather/model/weather_model.dart';
import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const Weather({
    required this.weatherInfo,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final day = weatherInfo.dt_txt.split(" ")[0].split("-");
    final time = weatherInfo.dt_txt.split(" ")[1].split(":");
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: Colors.black,width: 0.5)
      ),
      child: SizedBox(
        width: 100,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                day[1]+'/'+day[2],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
            ),
            Text(
              time[0]+'시',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 16),
            weatherInfo.weather[0].main == 'Clear' ?
            Icon(
              Icons.sunny,
              color: Colors.red,
            )
            : weatherInfo.weather[0].main == 'Clouds' ?
            Icon(
              Icons.cloud,
              color: Colors.blue,
            ) : Icon(
              Icons.cloudy_snowing,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              weatherInfo.main.humidity.toString()+'%',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 16,),
            Text(
              (weatherInfo.main.temp-273.15).floor().toString()+' 도',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }
}
