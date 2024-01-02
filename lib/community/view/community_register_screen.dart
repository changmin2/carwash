import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
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

  final categories = ['자유게시판', '세차라이프', '질문게시판'];

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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 제목
              Row(
                children: [
                  Text('제목', style: Theme.of(context).textTheme.titleMedium),
                  const Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),

              Form(
                key: _titleKey,
                child: TextFormField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(
                    hintText: '제목을 입력하세요.',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "제목을 입력해주세요.";
                    }
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// 내용
              Row(
                children: [
                  Text('내용', style: Theme.of(context).textTheme.titleMedium),
                  const Text(' *', style: TextStyle(color: Colors.red)),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),

              Form(
                key: _contentKey,
                child: TextFormField(
                  onChanged: (value) {
                    content = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "내용을 입력해주세요.";
                    }
                  },
                  decoration: const InputDecoration(hintText: '자유롭게 내용을 작성하세요.'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// 태그
              Text('태그', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),
              Form(
                // key: _titleKey,
                child: TextFormField(
                  onChanged: (value) {
                    // title = value;
                  },
                  decoration: const InputDecoration(
                    hintText: '태그를 입력하세요.',
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// 등록 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_titleKey.currentState!.validate() && _contentKey.currentState!.validate()) {
                      final user = ref.read(userMeProvider) as UserModel;
                      RequestRegisterParam param = RequestRegisterParam(
                        creator: user.nickname,
                        content: content!,
                        title: title!,
                        category: category,
                      );

                      ref.read(communityRepositoryProvider).register(param);

                      await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('등록완료!!'),
                        duration: Duration(seconds: 3),
                      ));
                      
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('등록'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
