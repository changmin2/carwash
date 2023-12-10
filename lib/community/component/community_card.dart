import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/community/view/community_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/sizes.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.goNamed(CommunityDetailScreen.routeName,
            pathParameters: {'id':'1'});
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: TRoundedContainer(
          width: double.infinity,
          height: 150,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 110,
                    height: 35,
                    child: Card(
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          '질문게시판',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    '오늘은 비가 주르륵.....',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle_rounded
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '세린이',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.favorite_outline
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '16',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
