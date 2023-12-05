import 'package:carwash/car/component/select_card.dart';
import 'package:carwash/car/provider/select_provider.dart';
import 'package:carwash/car/view/register_thrid_screen.dart';
import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecordSecondScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordTwo';
  final query;

  const RecordSecondScreen({this.query, Key? key}) : super(key: key);
  @override
  ConsumerState<RecordSecondScreen> createState() => _RecordTwoScreenState();
}

class _RecordTwoScreenState extends ConsumerState<RecordSecondScreen> {
  var newList = [];
  static get routeName => 'recordTwo';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newList = widget.query
        .toString()
        .split('[')[1]
        .toString()
        .split(']')[0]
        .toString()
        .split(',')
        .toList();
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
                itemCount: newList.length,
                itemBuilder: (context, index) {
                  String washType = newList[index];
                  return TRoundedContainer(
                    margin: const EdgeInsets.only(bottom: TSizes.sm),
                    showBorder: true,
                    key: ValueKey(washType),
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      title: Text(
                        washType,
                        style: Theme.of(context).textTheme.titleMedium,
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
                    final element = newList.removeAt(oldIndex);
                    newList.insert(newIndex, element);
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
                  context.goNamed(RecordThridScreen.routeName,
                      queryParameters: {"query": newList.toString()});
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
