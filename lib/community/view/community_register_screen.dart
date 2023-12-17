import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/community/model/requestRegister_model.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:carwash/user/model/user_model.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityRegisterScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityRegisterScreen';
  const CommunityRegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityRegisterScreen> createState() => _CommunityRegisterState();
}

class _CommunityRegisterState extends ConsumerState<CommunityRegisterScreen> {
  String? title = '';
  String? content = '';
  String category = '자유게시판';

  final _titleKey = GlobalKey<FormState>();
  final _contentKey = GlobalKey<FormState>();
  final _categoryKey = GlobalKey<FormState>();

  final categories = ['자유게시판','세차라이프','질문게시판'];

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: SingleChildScrollView(
        child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '제목',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 25)
                  ),
                  const SizedBox(height: 3),
                  Form(
                    key: _titleKey,
                    child: TextFormField(
                      onChanged: (value){
                        this.title = value;
                      },
                      decoration: InputDecoration(
                          hintText: '처음 뵙겠습니다.',
                          border: OutlineInputBorder()),
                      validator: (value){
                        if(value!.length<1){
                          return "제목을 입력해주세요.";
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('내용',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25)
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Form(
                      key: _contentKey,
                      child: TextFormField(
                        onChanged: (value){
                          this.content = value;
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
                    ),
                  ),
                  Row(
                    children: [
                      Text('카테고리',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20)
                      ),
                      SizedBox(width: 16),
                      DropdownButton(
                          value: category,
                          items: categories.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              category = value!;
                            });
                          }
                      ),

        
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(100,40),
                          backgroundColor: Colors.brown
                        ),
                        onPressed: ()async {
                          if(_titleKey.currentState!.validate() && _contentKey.currentState!.validate()){
                            final user = ref.read(userMeProvider) as UserModel;
                            RequestRegisterParam param = new RequestRegisterParam(
                                creator: user.nickname,
                                content: this.content!,
                                title: this.title!,
                                category: this.category
                            );
                            ref.read(communityRepositoryProvider).register(param);
                            await ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('등록완료!!'),
                                  duration: Duration(seconds: 3),
                                )
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          '등록'
                        )
                    ),
                  ),
        
                ]
            )
        ),
      ),
    );
  }
}
