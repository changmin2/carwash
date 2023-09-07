import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';


  @override
  Widget build(BuildContext context,WidgetRef) {

    return Image.asset(
                  'asset/img/splash.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                );
  }
}
