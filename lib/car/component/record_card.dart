import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: SizedBox(
        height: 70,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          elevation: 4.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Image.asset(
                'asset/img/record.png'
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '2023-09-24'
                  ),
                  SizedBox(height: 8),
                  Text(
                    '화곡동 카워시'
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}