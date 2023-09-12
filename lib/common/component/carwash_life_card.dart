import 'package:flutter/material.dart';

class CarWashLife extends StatelessWidget {
  const CarWashLife({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: 200,
        height: 270,
        child: Column(
          children: [
            Image.asset(
                'asset/img/car_image.jpeg',
                fit: BoxFit.fill,
                height: 200,
            ),
            SizedBox(height: 8,),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '세린이'
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text(
                        '120'
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '오늘 세차 맛집 다녀 왔습니다!',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700
              ),
            )

          ],
        ),
      ),
    );
  }
}
