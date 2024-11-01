import 'package:carwash/car/model/accountBookDto.dart';
import 'package:carwash/car/provider/accountBook_provider.dart';
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/component/rounded_container.dart';
import '../../../common/utils/formatters/formatter.dart';
import '../../../common/utils/helpers/helper_functions.dart';

class AccountRegisterScreen extends ConsumerStatefulWidget {
  const AccountRegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountRegisterScreen> createState() => _AccountRegisterScreenState();
}

class _AccountRegisterScreenState extends ConsumerState<AccountRegisterScreen> {
  //1: 지출, 2: 정비, 3: 주유
  var category = '지출';
  var _day = TFormatter.formatDate(DateTime.now());
  DateTime _prameterDay = DateTime.now();
  var _cost;
  var _title = '';
  var _memo = '';
  final categories = ['지출', '정비', '주유'];

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back
          )
        ),
        centerTitle: true,
        title: DropdownButton(
            underline: const SizedBox(),
            style: Theme.of(context).textTheme.titleLarge,
            value: category,
            items: categories
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                category = value!;
              });
            }),
        actions: [
          IconButton(
              onPressed: (){
                if (_day == '') {
                  THelperFunctions.showSnackBar(context, "세차일자를 선택하세요.");
                  return;
                }
                if (_title == '') {
                  THelperFunctions.showSnackBar(context, "지출 항목을 입력하세요.");
                  return;
                }
                if (_cost == null) {
                  THelperFunctions.showSnackBar(context, "지출 비용을 입력하세요.");
                  return;
                }

                ref.read(accountBookProvider.notifier).add(
                  AccountBookDto(date: _prameterDay, category: category, cost: _cost,memo: _memo,title: _title)
                );
                context.pop();
              },
              icon: Icon(
                Icons.check,
                color: PRIMARY_COLOR,
              )),
          SizedBox(width: 10,)
        ],
      ),
      child:
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: category != '임시'
                ?
            Column(
              children: [
                /// 세차일자
                TRoundedContainer(
                  radius: 14,
                  showBorder: true,
                  child: ListTile(
                    title: Text(
                      _day,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
                        final selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2099));
                        if (selectedDate != null) {

                            setState(() {
                              _prameterDay = selectedDate;
                              _day = TFormatter.formatDate(selectedDate);
                            });

                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  child: TextFormField(
          
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: '지출항목을 입력하세요',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2,color: Colors.blue)
                        ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 1,color: Colors.grey)
                      )
                    ),
                    onChanged: (value){
                      _title = value!;
                    },
                    onSaved: (value){
                      _title = value!;
                    },
                    style: Theme.of(context).textTheme.titleSmall,
          
                  ),
                ),
          
                const SizedBox(height: 16),
                /// 지출 비용
                Container(
                  height: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: '지출 비용을 입력하세요',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2,color: Colors.blue)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1,color: Colors.grey)
                        )
                        // suffixIcon: const Icon(
                        //   Icons.ice_skating
                        // )
                    ),
                    inputFormatters: [
                      //FilteringTextInputFormatter.digitsOnly,
                      CurrencyTextInputFormatter.currency(
                        locale: 'ko',
                        decimalDigits: 0,
                        symbol: '￦',
                      ),
          
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      value = value!.split('￦')[1].replaceAll(",", "");
                      _cost = int.parse(value!);
                    },
                    onSaved: (value){
                      value = value!.split('￦')[1].replaceAll(",", "");
                      _cost = int.parse(value!);
                    },
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall,
          
                  ),
                ),
                const SizedBox(height: 16),
                /// 메모
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  child: TextFormField(
                    expands: true,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: '메모 할 내용을 입력하세요',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2,color: Colors.blue)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 1,color: Colors.grey)
                        )
                      // suffixIcon: const Icon(
                      //   Icons.ice_skating
                      // )
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical(y: -1.0),
                    onChanged: (value){
                      _memo = value!;
                    },
                    onSaved: (value){
                      _memo = value!;
                    },
                    style: Theme.of(context).textTheme.titleSmall,

                  ),
                ),
              ],
            )
                :
            Container()
          ),
        )
    );
  }
}
