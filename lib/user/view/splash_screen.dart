import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'asset/img/intro.png',
            fit: BoxFit.cover,
          ),
          const Positioned(
            bottom: 60,
            child: Column(
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  child: Text("베타 버전"),
                ),
                SizedBox(height: TSizes.sm),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  child: Text("1.0.22"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
