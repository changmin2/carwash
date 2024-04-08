import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/weather/model/weatherView_model.dart';
import 'package:carwash/weather/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class Weather extends StatelessWidget {
  final WeatherViewModel weatherInfo;

  const Weather({required this.weatherInfo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final day = weatherInfo.dt_txt.split(" ")[0].split("-");
    final time = weatherInfo.dt_txt.split(" ")[1].split(":");
    final week = DateFormat('E','ko_KR').format(DateTime.parse(day[0] +'-' + day[1] + '-' +day[2]));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 날짜
        Text(
          '${day[1]}/${day[2]}(${week})',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        Row(
          children: [
            const Icon(
              Icons.water_drop_outlined,
              size: 16,
            ),

            const SizedBox(
              width: TSizes.xs,
            ),

            /// 습도인데 강수확률로 변경 요청
            Text(
              '${weatherInfo.humidity}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        /// 오전 날씨 아이콘
        weatherInfo.m_weather == 'Clear'
            ? const Icon(
          Iconsax.sun_14,
          color: Colors.red,
          size: 24,
        )
            : weatherInfo.m_weather == 'Clouds'
            ? const Icon(
          Iconsax.cloud,
          color: Colors.grey,
          size: 24,
        )
            : const Icon(
          Iconsax.cloud_drizzle,
          color: Colors.blue,
          size: 24,
        ),


        /// 오후 6시 날씨 아이콘
        weatherInfo.a_weather == 'Clear'
            ? const Icon(
                Iconsax.sun_14,
                color: Colors.red,
                size: 24,
              )
            : weatherInfo.a_weather == 'Clouds'
                ? const Icon(
                    Iconsax.cloud,
                    color: Colors.grey,
                    size: 24,
                  )
                : const Icon(
                    Iconsax.cloud_drizzle,
                    color: Colors.blue,
                    size: 24,
                  ),

        /// 최저 온도
        SizedBox(
          width: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${(weatherInfo.temp_min - 273.15).floor()}℃',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        /// 최고 온도
        SizedBox(
          width: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${(weatherInfo.temp_max - 273.15).floor()}℃',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
