import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '세린이',
                    style: TextStyle(
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '차가 너무 멋져요'
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: 55),
          child: Text(
            '2023.03.24'
          ),
        )
      ]
      ),
    );
  }
}
