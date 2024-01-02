import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/component/rounded_image.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/community/view/community_free/widget/community_free_hot_card.dart';
import 'package:carwash/community/view/community_free/widget/community_free_list_widget.dart';
import 'package:carwash/community/view/widget/community_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCommunityFreeScreen extends StatelessWidget {
  const TCommunityFreeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defalutSpace),
        child: Column(
          children: [
            /// HOT 자유게시판
            /// HOT section header
            const TCommunitySectionHeading(
              firstTitle: 'HOT',
              firstTitleColor: Colors.red,
              secondTitle: '자유게시판',
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// HOT 자유 리스트
            /// 요청사항 : 자유게시판 중 핫한 글 5개만
            SizedBox(
              height: 160,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __){
                  return const SizedBox(width: TSizes.sm);
                },
                itemBuilder: (BuildContext context, int index) {
                  return const TCommunityFreeHotCard(
                    imageUrl: 'asset/img/car_image.jpeg',
                    title: '오늘 세차 맛집 다녀 왔습니다! 너무 깨끗했고 시설도 좋았습니다.',
                  );
                },
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            const Divider(thickness: 1),

            const SizedBox(height: TSizes.spaceBtwItems),
            
            /// 자유게사판 리스트
            ListView.separated(
                itemCount: 5,
                // 리스트에 해당되는 영역만 차지
                shrinkWrap: true,
                // 스크롤이 되지 않게.
                primary: false,
                separatorBuilder: (_, index) {
                  return const Column(
                    children: [
                      SizedBox(height: TSizes.spaceBtwItems),
                      Divider(thickness: 1),
                      SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  );
                },
                itemBuilder: (_, int index) {
                  return const TCommunityFreeListWidget(
                    title: '세차하는 진정한 방법을 알려주겠다!',
                    nickName: '세차환자',
                    date: '2023.12.31',
                  );
                }),
          ],
        ),
      ),
    );
  }
}


