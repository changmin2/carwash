import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  var _prameterDay = '';
  var _cost = 0;
  var _cate = '';
  var _memo = '';
  final categories = ['지출', '정비', '주유'];

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(
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
      ),
      child:
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: category == '지출'
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
                          if (selectedDate.isAfter(DateTime.now())) {
                            THelperFunctions.showSnackBar(context, "오늘 이후의 날짜는 선택할 수 없습니다.");
                          } else {
                            setState(() {
                              _prameterDay = selectedDate.toString();
                              _day = TFormatter.formatDate(selectedDate);
                            });
                          }
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
                        hintText: '카테고리를 입력하세요',
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
                      _cate = value!;
                    },
                    onSaved: (value){
                      _cate = value!;
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
                      _cost = int.parse(value!);
                    },
                    onSaved: (value){
                      _cost = int.parse(value!);
                    },
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall,
          
                  ),
                ),
                const SizedBox(height: 16),
                /// 메모
                TextFormField(
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
                  onChanged: (value){
                    _memo = value!;
                  },
                  onSaved: (value){
                    _memo = value!;
                  },
                  style: Theme.of(context).textTheme.titleSmall,
          
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
