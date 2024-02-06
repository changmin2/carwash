import 'dart:io';

import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/car/model/register_params.dart';
import 'package:carwash/car/provider/recentRecord_provider.dart';
import 'package:carwash/car/provider/record_provider.dart';
import 'package:carwash/car/provider/state_provider.dart';
import 'package:carwash/car/repository/record_repository.dart';
import 'package:carwash/common/component/rounded_container.dart';
import 'package:carwash/common/const/data.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/common/utils/formatters/formatter.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../user/model/user_model.dart';

class RecordThridScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordThrid';
  final query;
  const RecordThridScreen({required this.query, Key? key}) : super(key: key);

  @override
  ConsumerState<RecordThridScreen> createState() => _RecordThridScreenState();
}

class _RecordThridScreenState extends ConsumerState<RecordThridScreen> {
  File? _image;
  var _day = '';
  var _prameterDay = '';
  var _place = '';
  var newList = [];
  var _downloadUrl = '';
  final ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newList = widget.query.toString().split('[')[1].toString().split(']')[0].toString().split(',').toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userMeProvider) as UserModel;
    return DefaultLayoutV2(
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
              
              /// 세차일자 라벨
              Text(
                '세차 일자',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              
              const SizedBox(height: TSizes.spaceBtwInputFields),
              
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
                      final selectedDate =
                      await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2099));
                      if (selectedDate != null) {
                        setState(() {
                          _prameterDay = selectedDate.toString();
                          _day = TFormatter.formatDate(selectedDate);
                          // _day =
                          //     '${DateFormat('yyyy년 MM월 dd일 ').format(selectedDate)}(${DateFormat('E', 'ko').format(selectedDate)})';
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              
              /// 세차장소 라벨
              Text(
                '세차 장소',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              
              const SizedBox(height: TSizes.spaceBtwInputFields),
              
              /// 세차장소 입력
              TextFormField(
                onChanged: (value) {
                  _place = value;
                },
                onSaved: (value) {
                  _place = value!;
                },
                // decoration: const InputDecoration(border: InputBorder.none),
                // style: const TextStyle(decorationThickness: 0),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              /// 사진 라벨
              Text(
                '사진',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

              /// 사진 등록
              DottedBorder(
                color: Colors.grey,
                dashPattern: const [5, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                child: Container(
                  width: 400,
                  height: 180,
                  decoration: _image != null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(_image!.path),
                            ),
                          ),
                        )
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            icon: _image == null
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  )
                                : Container(),
                          ),
                          _image == null
                              ? Text(
                                  '카메라',
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                )
                              : Container()
                        ],
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            icon: _image == null
                                ? Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
                                    child: Icon(
                                      CupertinoIcons.arrow_up_doc,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  )
                                : Container(),
                          ),
                          _image == null
                              ? Text(
                                  '갤러리',
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                )
                              : Container()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: TSizes.spaceBtwSections),

              /// 완료 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    //await uploadImage();
                    if(_day == ''){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("세차일자를 선택하세요."),
                        duration: Duration(milliseconds: 500),
                      ));
                      return;
                    }
                    else if(_place == ''){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("세차 장소를 입력하세요."),
                        duration: Duration(milliseconds: 500),
                      ));
                      return;
                    }
                    else if(_image == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("이미지를 선택하세요."),
                        duration: Duration(milliseconds: 500),
                      ));
                      return;
                    }else{
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context){
                            return Container(
                              height: 100,
                              child: Center(
                                  child: Text(
                                      '업로드중...'
                                  )
                              ),
                            );
                          }
                      );

                      await s3Upload();
                      RecordRegisterParams params =
                      RecordRegisterParams(image: _downloadUrl, place: _place.toString(), date: _prameterDay.toString(), washList: newList);
                      recordDto re = await ref.read(recordRepositoryProvider).recordRegister(recordRegisterParams: params);
                      await ref.read(RecordProvider('true').notifier).getRecord(false);
                      ref.read(recentRecordProvider(user.username).notifier).add(re);
                      ref.read(stateProvider).change();

                      context.go('/');
                    }

                  },
                  child: const Text('완료'),
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
    var ref = storage.ref().child('washRecord/$now.png');
    await ref.putFile(_image!);
    _downloadUrl = await ref.getDownloadURL(); //이미지 파일의 url
  }

  Future<void> s3Upload() async {
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(_image!.openRead()));
    // get file length
    var length = await _image!.length();

    // string to uri
    var uri = Uri.parse("http://$ip/s3/upload");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(_image!.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    // listen for response
    await response.stream.transform(utf8.decoder).listen((value) {
      _downloadUrl = value.toString();
    });
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(
        source: imageSource,
        imageQuality: 60
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
