import 'package:flutter/material.dart';

class WashListCard extends StatelessWidget {
  final int step;
  final String wash;
  const WashListCard({
    required this.step,
    required this.wash,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 120,
      child: Card(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  step.toString()
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                wash,
                maxLines: 10,
              )
            ],
          ),
      ),
    );
  }
}
