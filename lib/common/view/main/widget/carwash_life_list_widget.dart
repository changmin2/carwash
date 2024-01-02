import 'package:carwash/community/model/community_model.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../community/provider/communityProvider.dart';
import '../../../../community/view/community_detail_screen.dart';
import '../../../component/carwash_life_card.dart';
import '../../../const/sizes.dart';

class CarWashLifeListWidget extends ConsumerStatefulWidget {
  const CarWashLifeListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<CarWashLifeListWidget> createState() => _CarWashLifeListWidgetState();
}

class _CarWashLifeListWidgetState extends ConsumerState<CarWashLifeListWidget> {

  var recentCommunity = [];
  // 비동기 처리
  Future _future() async {
    recentCommunity = await ref.read(communityRepositoryProvider).recentCommunity(); // 5초를 강제적으로 딜레이 시킨다.
    return 'Success'; // 5초 후 '짜잔!' 리턴
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
        if (snapshot.hasData == false) {
          return CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
        }

        //error가 발생하게 될 경우 반환하게 되는 부분
        else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),

            child: Text(
              'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
              style: TextStyle(fontSize: 15),
            ),
          );
        }
        else{
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '세차 라이프',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue),
                    ),
                  )
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: recentCommunity.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: CarWashLife(model:recentCommunity[index])
                    );
                  },
                ),
              ),
            ],
          );
        }
      },

    );
  }
}
