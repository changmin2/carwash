import 'package:carwash/car/provider/select_provider.dart';
import 'package:carwash/car/view/register_first_screen.dart';
import 'package:carwash/car/view/register_thrid_screen.dart';
import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/user/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../provider/myrecord_provider.dart';

class RecordSecondScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordTwo';
  int flag;
  RecordSecondScreen({
    this.flag = 0,
    Key? key}) : super(key: key);
  @override
  ConsumerState<RecordSecondScreen> createState() => _RecordTwoScreenState();
}

class _RecordTwoScreenState extends ConsumerState<RecordSecondScreen> {
  final washList = ['매트세척', '시트세정', '시트코팅', '휠세척', '고압수', '프리워시', '스노우폼', '본세차', '철분제거', '페인트클렌저', '클레잉', '유막제거', '발수코팅', '폴리싱', '탈지', '실런트', '고체왁스', '물왁스', '드라잉', '타이어코팅', '휠코팅', '엔진룸세척', '트렁크정리'];
  List<String> selectList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final select = ref.read(SelectProvider).selects;
    if(widget.flag == 2){
      selectList = ref.read(MyRecordProvider);
    }else{
      for (var i = 0; i < washList.length; i++) {
        select[i] == 1 ? selectList.add(washList[i]) : null;
      }
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

            const SizedBox(height: TSizes.spaceBtwItems),

            /// 추가 버튼 설명
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Opacity(
                  opacity: 0.5,
                  child: Icon(Icons.add),
                ),
                const SizedBox(width: TSizes.xs),
                Text(
                  '버튼 : 내용 추가',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            /// 삭제 버튼 설명
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Opacity(
                  opacity: 0.5,
                  child: Icon(Icons.remove),
                ),
                const SizedBox(width: TSizes.xs),
                Text(
                  '버튼 : 기록 삭제',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            /// 이동 버튼 설명
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Opacity(
                  opacity: 0.5,
                  child: Icon(Icons.reorder_outlined),
                ),
                const SizedBox(width: TSizes.xs),
                Text(
                  '버튼 : 순서 변경',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// 선택된 세차내용 리스트
            Expanded(
              child: ReorderableListView.builder(
                itemCount: selectList.length,
                itemBuilder: (context, index) {
                  String washType = selectList[index];
                  return TRoundedContainer(
                    key: ValueKey(washType + index.toString()),
                    margin: const EdgeInsets.only(bottom: TSizes.sm),
                    showBorder: true,
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 세차내용
                          Text(
                            washType,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// + 버튼
                              IconButton(
                                onPressed: () {
                                  selectList.insert(index, selectList[index]);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.add),
                              ),

                              /// - 버튼
                              IconButton(
                                onPressed: () {
                                  selectList.removeAt(index);
                                  setState(() {
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.reorder_outlined),
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
            widget.flag == 0
            ?
            /// 다음 단계 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.goNamed(RecordThridScreen.routeName, queryParameters: {"query": selectList.toString()});
                },
                child: const Text('다음 단계'),
              ),
            )
            :
            widget.flag == 1
            ?
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(MyRecordProvider.notifier).registerRecord(selectList.toString());
                  ref.read(MyRecordProvider.notifier).change(selectList);

                  while(context.canPop()){
                    context.pop();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfileScreen(

                    )),
                  );


                },
                child: const Text('등록하기'),
              ),
            )
            :
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecordFirstScreen(
                      flag: 1,

                    )),
                  );

                },
                child: const Text('변경하기'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
