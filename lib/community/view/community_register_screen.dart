import 'dart:io';

import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/helpers/helper_functions.dart';
import 'package:carwash/community/model/requestRegister_model.dart';
import 'package:carwash/community/provider/communityProvider.dart';
import 'package:carwash/community/repository/community_repository.dart';
import 'package:carwash/community/view/community_screen.dart';
import 'package:carwash/user/model/user_model.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../common/const/data.dart';

class CommunityRegisterScreen extends ConsumerStatefulWidget {
  static get routeName => 'communityRegisterScreen';
  String category;
  CommunityRegisterScreen({
    this.category = '자유게시판',
    Key? key}) : super(key: key);

  @override
  ConsumerState<CommunityRegisterScreen> createState() => _CommunityRegisterState();
}

class _CommunityRegisterState extends ConsumerState<CommunityRegisterScreen> {
  String? title = '';
  String? content = '';
  String? tag = '';
  final picker = ImagePicker();
  XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
  List<XFile?> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
  List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수
  List<String?> _downloadUrls = [];
  FirebaseStorage storage = FirebaseStorage.instance;

  final _titleKey = GlobalKey<FormState>();
  final _contentKey = GlobalKey<FormState>();
  final _tagKey = GlobalKey<FormState>();

  final categories = ['자유게시판', '세차라이프', '질문게시판'];

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton(
            underline: const SizedBox(),
            style: Theme.of(context).textTheme.titleLarge,
            value: widget.category,
            items: categories
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                widget.category = value!;
              });
            }),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defalutSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '부적절하거나 불쾌감을 줄 수 있는 컨텐츠는 제재를 받을 수 있습니다.',
                style: TextStyle(
                    color: Colors.red
                ),
              ),
              const SizedBox(height: 16),
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
                  decoration: const InputDecoration(hintText: '내용을 입력하세요.'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// 태그
              Text('태그', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),
              Form(
                key: _tagKey,
                child: TextFormField(
                  onChanged: (value) {
                    tag = value;
                  },
                  decoration: const InputDecoration(
                    hintText: '태그를 입력하세요.',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "태그를 하나 입력하세요.";
                    }
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// 사진등록
              Text('사진등록', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: TSizes.spaceBtwInputFields / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //카메라로 촬영하기
                  TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor: const Color(0xff2F80ED),
                    child: IconButton(
                      onPressed: () async {
                        image = await picker.pickImage(source: ImageSource.camera, imageQuality: 30,
                            maxHeight: 300,
                            maxWidth: 500);
                        //카메라로 촬영하지 않고 뒤로가기 버튼을 누를 경우, null값이 저장되므로 if문을 통해 null이 아닐 경우에만 images변수로 저장하도록 합니다
                        if (image != null) {
                          if (images.length > 2) {
                            THelperFunctions.showSnackBar(context, '사진은 3개까지 등록 할 수 있습니다.');
                            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('사진은 3개까지 등록 할 수 있습니다.')));
                          } else {
                            setState(() {
                              images.add(image);
                            });
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: TSizes.spaceBtwItems / 2),

                  /// 갤러리에서 가져오기
                  TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.sm),
                    backgroundColor: const Color(0xff2F80ED),
                    child: IconButton(
                      onPressed: () async {
                        multiImage = await picker.pickMultiImage(
                            imageQuality: 30,
                            maxHeight: 300,
                            maxWidth: 500
                        );
                        if (multiImage.length > 3 || (multiImage.length - images.length).abs() > 3) {
                          THelperFunctions.showSnackBar(context, '사진은 3개까지 등록 할 수 있습니다.');
                        }
                        setState(() {
                          images.addAll(multiImage);
                        });
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 사진 목록
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: images.length, //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 사진 개수
                  childAspectRatio: 1 / 1, //사진 의 가로 세로의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(TSizes.sm),
                          image: DecorationImage(
                            fit: BoxFit.cover, //사진 크기를 Container 크기에 맞게 조절
                            image: FileImage(
                              // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                              File(images[index]!.path),
                            ),
                          ),
                        ),
                      ),
                      TRoundedContainer(
                        backgroundColor: Colors.black,
                        radius: TSizes.xs,
                        width: 24,
                        height: 24,
                        //삭제 버튼
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 10,
                          ),
                          onPressed: () {
                            //버튼을 누르면 해당 이미지가 삭제됨
                            setState(() {
                              images.remove(images[index]);
                            });
                          },
                        ),
                      )
                    ],
                  );
                },
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// 등록 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_titleKey.currentState!.validate() && _contentKey.currentState!.validate() && _tagKey.currentState!.validate()) {
                      final user = ref.read(userMeProvider) as UserModel;


                      if(widget.category == '세차라이프'){
                        if(images.length == 0){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("세차라이프는 이미지를 하나 이상 선택해야합니다."),
                            duration: Duration(milliseconds: 500),
                          ));
                          return;
                        }else{
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return const SizedBox(
                                  height: 100,
                                  child: Center(child: Text('업로드 중...')),
                                );
                              });
                          await s3Upload();
                          RequestRegisterParam param = RequestRegisterParam(
                            creator: user.nickname,
                            content: content!,
                            title: title!,
                            category: widget.category,
                            hastag: tag!,
                            imgUrl: _downloadUrls == null ? '' : _downloadUrls.toString()!,
                          );

                          await ref.read(communityRepositoryProvider).register(param);
                          //뒤로가기시 페이지 갱신
                          await ref.read(communityProvider.notifier).paginate(forceRefetch: true);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }

                      }else{
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const SizedBox(
                                height: 100,
                                child: Center(child: Text('업로드 중...')),
                              );
                            });
                        await s3Upload();
                        RequestRegisterParam param = RequestRegisterParam(
                          creator: user.nickname,
                          content: content!,
                          title: title!,
                          category: widget.category,
                          hastag: tag!,
                          imgUrl: _downloadUrls == null ? '' : _downloadUrls.toString()!,
                        );
                        await ref.read(communityRepositoryProvider).register(param);
                        //뒤로가기시 페이지 갱신
                        await ref.read(communityProvider.notifier).paginate(forceRefetch: true);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }

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

  Future<void> uploadImage() async {
    final now = DateTime.now();
    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        File _file = File(images[i]!.path);

        var ref = storage.ref().child('washRecord/$now' + i.toString() + '.png');
        await ref.putFile(_file);

        _downloadUrls.add(await ref.getDownloadURL());
      }
    }
  }

  Future<void> s3Upload() async {
    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        // open a bytestream
        var stream = new http.ByteStream(DelegatingStream.typed(images[i]!.openRead()));
        // get file length
        var length = await images[i]!.length();

        // string to uri
        var uri = Uri.parse("http://$ip/s3/upload");

        // create multipart request
        var request = new http.MultipartRequest("POST", uri);

        // multipart that takes file
        var multipartFile = new http.MultipartFile('file', stream, length,
            filename: basename(images[i]!.path));

        // add file to multipart
        request.files.add(multipartFile);

        // send
        var response = await request.send();
        // listen for response
        await response.stream.transform(utf8.decoder).listen((value) {
          _downloadUrls.add(value.toString());
        });
      }
    }

  }
}
