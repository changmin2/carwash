import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final int index;
  const EventCard({
    required this.index,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(index.toString());
    return Card(
      color: index ==0 ? Colors.amberAccent[100] : Colors.greenAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15,top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '자신만의 세차 방법을 공유해보세요',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15
                ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                    '세차를 공유하면 포인트를 드립니다!',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                  ),
                ),
                SizedBox(width: 10),
                TextButton(
                    onPressed: (){},
                    child: Text(
                      '확인'
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
