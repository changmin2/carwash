import 'package:carwash/car/component/select_card.dart';
import 'package:carwash/car/provider/select_provider.dart';
import 'package:carwash/car/view/register_second_screen.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/utils/helpers/helper_functions.dart';

class RecordFirstScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordFirst';

  const RecordFirstScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RecordFirstScreen> createState() => _RecordFirstScreenState();
}

class _RecordFirstScreenState extends ConsumerState<RecordFirstScreen> {
  final washList = ['매트세척', '시트세정', '시트코팅', '휠세척', '고압수', '프리워시', '스노우폼', '미트세차', '철분제거', '페인트클렌저', '클레잉', '유막제거', '발수코팅', '폴리싱', '탈지', '실런트', '고체왁스', '물왁스', '드라잉', '타이어코팅', '휠코팅', '엔진룸세척', '트렁크정리'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(SelectProvider).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(SelectProvider);

    return DefaultLayoutV2(
      /// 앱바
      appBar: AppBar(),

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 타이틀
              Text(
                '나만의 세차를\n기록하고 공유해보세요!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// 세차 목록
              Wrap(
                direction: Axis.horizontal, // 정렬 방향
                alignment: WrapAlignment.center, // 정렬 방식
                spacing: TSizes.sm, // 상하(좌우) 공간
                runSpacing: TSizes.sm, // 좌우(상하) 공간
                children: List.generate(
                  washList.length,
                  (i) => SelectCard(
                    select: state.selects[i],
                    index: i,
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// 다음 단계 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    var newList = [];
                    newList = await washList.where((element) => state.selects[washList.indexOf(element)] == 1).toList();

                    if(newList.isEmpty){
                      THelperFunctions.showSnackBar(context, "세차 기록을 선택해주세요!");
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordSecondScreen()),
                    );
                    //context.goNamed(RecordSecondScreen.routeName);
                  },
                  child: const Text('다음 단계'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// AppBar _renderAppbar(BuildContext context){
//   return AppBar(
//     leading: BackButton(
//
//     ),
//       // backgroundColor: Colors.white,
//       // centerTitle: true,
//       // elevation: 0,
//       // leading: Padding(
//       //   padding: EdgeInsets.only(left: 10),
//       //   child: IconButton(
//       //     onPressed: (){Navigator.pop(context);},
//       //     icon: Icon(Icons.arrow_back,size: 30),
//       //     color: Colors.brown,
//       //     alignment: Alignment.centerLeft,
//       //   ),
//       // )
//   );
// }
