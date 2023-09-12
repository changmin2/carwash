import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  final int day;
  final double temperature;
  final double humidity;

  const Weather({
    required this.day,
    required this.temperature,
    required this.humidity,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: Colors.black,width: 0.5)
      ),
      child: SizedBox(
        width: 100,
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '21일(월)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.sunny,
            ),
            SizedBox(height: 16),
            Text(
              '0%',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 16,),
            Text(
              '20`C',
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
