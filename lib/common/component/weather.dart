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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 날짜
        Text(
          '${day[1]}/${day[2]}(월)',
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
              '${weatherInfo.main.humidity}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const Icon(
          Iconsax.sun_14,
          color: Colors.red,
          size: 24,
        ),


        /// 오전 12시 날씨 아이콘
        // weatherInfo.weather[0].main == 'Clear'
        //     ? const Icon(
        //         Iconsax.sun_14,
        //         color: Colors.red,
        //         size: 25,
        //       )
        //     : weatherInfo.weather[0].main == 'Clouds'
        //         ? const Icon(
        //             Iconsax.cloud,
        //             color: Colors.grey,
        //             size: 25,
        //           )
        //         : const Icon(
        //             Iconsax.cloud_drizzle,
        //             color: Colors.blue,
        //             size: 25,
        //           ),

        /// 오후 6시 날씨 아이콘
        weatherInfo.weather[0].main == 'Clear'
            ? const Icon(
                Iconsax.sun_14,
                color: Colors.red,
                size: 24,
              )
            : weatherInfo.weather[0].main == 'Clouds'
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

        /// 최고 온도
        SizedBox(
          width: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${(weatherInfo.main.temp - 273.15).floor()}℃',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        /// 최저 온도
        SizedBox(
          width: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${(weatherInfo.main.temp - 273.15).floor()}℃',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
