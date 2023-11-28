import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/weather/model/weather_model.dart';
import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const Weather({required this.weatherInfo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = weatherInfo.dt_txt.split(" ")[0].split("-");
    final time = weatherInfo.dt_txt.split(" ")[1].split(":");

    return Container(
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day[1] + '/' + day[2],
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: TSizes.xs),

          Text(
            '${time[0]}시',
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: TSizes.xs / 2),

          weatherInfo.weather[0].main == 'Clear'
              ? const Icon(
                  Icons.sunny,
                  color: Colors.red,
                  size: 25,
                )
              : weatherInfo.weather[0].main == 'Clouds'
                  ? const Icon(
                      Icons.cloud,
                      color: Colors.grey,
                      size: 25,
                    )
                  : const Icon(
                      Icons.cloudy_snowing,
                      color: Colors.blue,
                      size: 25,
                    ),

          const SizedBox(height: TSizes.xs),

          Text(
            '${weatherInfo.main.humidity}%',
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: TSizes.xs / 2),

          Text(
            '${(weatherInfo.main.temp - 273.15).floor()}℃',
            style: Theme.of(context).textTheme.labelLarge,
          )
        ],
      ),
    );

    // return Card(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(20.0),
    //     side: const BorderSide(
    //       color: Colors.grey,
    //       width: 0.5,
    //     ),
    //   ),
    //   child: SizedBox(
    //     width: 70,
    //     height: 110,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           day[1] + '/' + day[2],
    //           style: Theme.of(context).textTheme.labelLarge,
    //         ),
    //         SizedBox(height: 4),
    //         Text(
    //           time[0] + '시',
    //           style: Theme.of(context).textTheme.labelLarge,
    //         ),
    //         SizedBox(height: 8),
    //         weatherInfo.weather[0].main == 'Clear'
    //             ? const Icon(
    //                 Icons.sunny,
    //                 color: Colors.red,
    //                 size: 25,
    //               )
    //             : weatherInfo.weather[0].main == 'Clouds'
    //                 ? const Icon(
    //                     Icons.cloud,
    //                     color: Colors.grey,
    //                     size: 25,
    //                   )
    //                 : const Icon(
    //                     Icons.cloudy_snowing,
    //                     color: Colors.blue,
    //                     size: 25,
    //                   ),
    //         SizedBox(height: 8),
    //         Text(
    //           weatherInfo.main.humidity.toString() + '%',
    //           style: Theme.of(context).textTheme.labelLarge,
    //         ),
    //         SizedBox(height: 4),
    //         Text(
    //           (weatherInfo.main.temp - 273.15).floor().toString() + ' 도',
    //           style: Theme.of(context).textTheme.labelLarge,
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
