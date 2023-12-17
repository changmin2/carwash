import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/community/component/category_card.dart';
import 'package:carwash/community/view/community_detail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/const/sizes.dart';
import '../model/community_model.dart';

class CommunityCard extends StatelessWidget {
  final CommunityModel community;
  const CommunityCard({
    required this.community,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.goNamed(CommunityDetailScreen.routeName,
            pathParameters: {'id':community.id.toString()});
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
                  CatergoryCard(category: community.category),
                  const SizedBox(height: 5,),
                  Text(
                    community.title,
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
                        community.creator,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.favorite_outline
                      ),
                      const SizedBox(width: 5),
                      Text(
                        community.favorite.toString(),
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
