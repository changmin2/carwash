import 'package:carwash/car/provider/select_provider.dart';
import 'package:carwash/car/view/register_thrid_screen.dart';
import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecordSecondScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordTwo';

  const RecordSecondScreen({ Key? key}) : super(key: key);
  @override
  ConsumerState<RecordSecondScreen> createState() => _RecordTwoScreenState();
}

class _RecordTwoScreenState extends ConsumerState<RecordSecondScreen> {
  final washList = [
    '매트세척',
    '시트세정',
    '시트코팅',
    '휠세척',
    '고압수',
    '프리워시',
    '스노우폼',
    '본세차',
    '철분제거',
    '페인트클렌저',
    '클레잉',
    '유막제거',
    '발수코팅',
    '폴리싱',
    '탈지',
    '실런트',
    '고체왁스',
    '물왁스',
    '드라잉',
    '타이어코팅',
    '휠코팅',
    '엔진룸세척',
    '트렁크정리'
  ];
  var selectList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final select = ref.read(SelectProvider).selects;
    for(var i = 0; i<washList.length; i++){
      select[i] == 1 ? selectList.add(washList[i]) : null;
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultLayoutV2(

      appBar: AppBar(),

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
            //trailing: ReorderableDragStartListener(
            //                             index: index, child: Icon(Icons.drag_handle)),

            const SizedBox(height: TSizes.spaceBtwSections),
            
            /// 선택된 리스트
            Expanded(
              child: ReorderableListView.builder(
                itemCount: selectList.length,
                itemBuilder: (context, index) {
                  String washType = selectList[index];
                  return TRoundedContainer(
                    margin: const EdgeInsets.only(bottom: TSizes.sm),
                    showBorder: true,
                    key: ValueKey(washType+index.toString()),
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Text(
                            washType,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          IconButton(
                              onPressed: (){
                                selectList.insert(index, selectList[index]);
                                setState(() {

                                });
                              },
                              icon: const Icon(Icons.add)
                          )
                        ]
                      ),
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.compare_arrows),
                      ),
                      onTap: () {/* Do something else */},
                    ),
                  );
                },
                // The reorder function
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex = newIndex - 1;
                    }
                    final element = selectList.removeAt(oldIndex);
                    selectList.insert(newIndex, element);
                  });
                },
              ),
            ),

            const SizedBox(height: TSizes.defalutSpace),

            /// 다음 단계 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(RecordThridScreen.routeName
                  ,queryParameters: {"query": selectList.toString()}
                  );
                },
                child: const Text('다음 단계'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
