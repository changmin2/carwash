import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityRegisterScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityRegisterScreen';
  const CommunityRegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityRegisterScreen> createState() => _CommunityRegisterState();
}

class _CommunityRegisterState extends ConsumerState<CommunityRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '제목',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30)
                ),
                const SizedBox(height: 8),
                TextFormField(
                  onChanged: (value){
                  },
                  decoration: InputDecoration(
                      hintText: '처음 뵙겠습니다.',
                      border: OutlineInputBorder()),
                  validator: (value){
                    if(value!.length<1){
                      return "dhsmf";
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text('내용',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30)
                ),
                Expanded(
                    child:
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                      child: TextFormField(
                        onChanged: (value){
                        },
                        validator: (value){
                          if(value!.length<1){
                            return "내용을 입력해주세요.";
                          }
                        },
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            hintText: 'Ex) 좋은 세차 방법 추천해주세요.',
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                      ),
                    )),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100,40),
                        backgroundColor: Colors.brown
                      ),
                      onPressed: (){},
                      child: Text(
                        '등록'
                      )
                  ),
                )
              ]
          )
      ),
    );
  }
}
