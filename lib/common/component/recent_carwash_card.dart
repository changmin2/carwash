import 'package:flutter/material.dart';

class RecentCarWashCard extends StatelessWidget {
  const RecentCarWashCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,

      child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(
                Icons.car_crash_sharp,
                size: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '2023-05-04',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    '화곡동 카워시',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
