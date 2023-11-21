import 'package:carwash/car/model/recordDto.dart';
import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  final Event record;


  const RecordCard({
    required this.record,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.date.toString().split(" ")[0]
                  ),
                  SizedBox(height: 8),
                  Text(
                    record.place
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

class Event {
  int id;
  String memberId;
  String imgUrl;
  String washList;
  String place;
  DateTime date;
  Event(
      this.id,
      this.memberId,
      this.imgUrl,
      this.washList,
      this.place,
      this.date
      );
}