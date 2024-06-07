import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../weather/provider/weather_provider.dart';


class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';


  @override
  Widget build(BuildContext context,WidgetRef ref) {

    return Container(
      color: Colors.white,
      child: Image.asset(
                    'asset/img/intro.png',
                    fit: BoxFit.cover,
                  ),
    );
  }
}
