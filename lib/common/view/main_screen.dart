import 'package:carwash/common/component/carwash_life_card.dart';
import 'package:carwash/common/component/event_card.dart';
import 'package:carwash/common/component/recent_carwash_card.dart';
import 'package:carwash/common/component/weather.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      backgroundColor: Color.fromRGBO(42, 157, 143,30),
      appBar: renderAppBar(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(right: 25,left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 170,
                    child: OutlinedButton.icon(
                      // 텍스트버튼에 아이콘 넣기
                      onPressed: () {
                      },
                      icon: Icon(
                          Icons.airport_shuttle,
                          size: 30,
                          color: Colors.deepOrangeAccent
                      ),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                            '세차기록',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                            ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color:Colors.white,
                            width: 2
                          ),

                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 170,
                    child: OutlinedButton.icon(
                      // 텍스트버튼에 아이콘 넣기
                      onPressed: () {
                      },
                      icon: Icon(
                          Icons.diversity_1_outlined,
                          size: 30,
                          color: Colors.deepOrangeAccent
                      ),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          '커뮤니티',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                            color:Colors.white,
                            width: 2
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.handshake,
                          color: Colors.red,
                        ),
                        SizedBox(width: 20),
                        Text(
                          '오늘은 세차하기 좋은 날이에요!',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        height: 170,
                        child: ListView.builder(
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Weather(
                                  day: 0,
                                  temperature: 0,
                                  humidity: 0
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        height: 120,
                        child: ListView.builder(
                          itemCount: 2,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: EventCard(index:  index,),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 1,
                      width: 500,
                      color: Colors.greenAccent,
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '세차 라이프',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child: Text(
                                'See all',
                                style: TextStyle(
                                  color: Colors.blue
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        height: 270,
                        child: ListView.builder(
                          itemCount: 7,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: CarWashLife()
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '최근 세차',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          TextButton(
                              onPressed: (){},
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    color: Colors.blue
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Container(
                        height: 270,
                        child: ListView.builder(
                          itemCount: 7,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: RecentCarWashCard()
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

AppBar renderAppBar(context){
  return AppBar(
    backgroundColor: Color.fromRGBO(42, 157, 143,75),
    elevation: 0.0,
    title: Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        '세차파트너',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25
        ),
      ),
    ),
    actions: [
      IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 30,
          )
      ),
      Padding(
        padding: EdgeInsets.only(right: 20),
        child: IconButton(
            onPressed: (){},
            icon: Icon(
                Icons.list,
                size: 35,
            )
        ),
      )
    ],
  );
}