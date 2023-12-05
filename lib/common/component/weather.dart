import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/weather/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Weather extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const Weather({required this.weatherInfo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = weatherInfo.dt_txt.split(" ")[0].split("-");
    final time = weatherInfo.dt_txt.split(" ")[1].split(":");

    return TRoundedContainer(
      width: 70,
      radius: 12,
      showBorder: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 날짜
          Text(
            '${day[1]}/${day[2]}',
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: TSizes.xs),

          /// 시간
          Text(
            '${time[0]}시',
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: TSizes.xs / 2),

          /// 날씨 아이콘
          weatherInfo.weather[0].main == 'Clear'
              ? const Icon(
                  Iconsax.sun_14,
                  color: Colors.red,
                  size: 25,
                )
              : weatherInfo.weather[0].main == 'Clouds'
                  ? const Icon(
                      Iconsax.cloud,
                      color: Colors.grey,
                      size: 25,
                    )
                  : const Icon(
                      Iconsax.cloud_drizzle,
                      color: Colors.blue,
                      size: 25,
                    ),

          const SizedBox(height: TSizes.xs),

          /// 습도?
          Text(
            '${weatherInfo.main.humidity}%',
            style: Theme.of(context).textTheme.labelLarge,
          ),

          const SizedBox(height: TSizes.xs / 2),

          /// 온도
          Text(
            '${(weatherInfo.main.temp - 273.15).floor()}℃',
            style: Theme.of(context).textTheme.labelLarge,
          )
        ],
      ),
    );
  }
}
