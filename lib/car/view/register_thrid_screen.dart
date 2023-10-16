import 'dart:convert';
import 'dart:io';

import 'package:carwash/car/model/register_params.dart';
import 'package:carwash/car/repository/record_repository.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class RecordThridScreen extends ConsumerStatefulWidget {
  static get routeName => 'recordThrid';
  final query;
  const RecordThridScreen({
    required this.query,
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<RecordThridScreen> createState() => _RecordThridScreenState();
}

class _RecordThridScreenState extends ConsumerState<RecordThridScreen> {
  XFile? _image;
  var _day = '';
  var _prameterDay = '';
  var _place = '';
  var newList = [];
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newList = widget.query.toString().split('[')[1].toString().split(']')[0].toString().split(',').toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: _renderAppbar(context),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '나만의 세차를 기록하고 공유해보세요!',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '세차  일자',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(width: 0.4)
                ),
                child: ListTile(
                  title: Text(
                    _day,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2099)
                      );
                      if(selectedDate!=null){
                        setState(() {
                          _prameterDay = selectedDate.toString();
                          _day = DateFormat('yyyy년 MM월 dd일 ').format(selectedDate)
                              +'('+ DateFormat('E','ko').format(selectedDate)+')';
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                '세차  장소',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(height: 8,),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(width: 0.4)
                ),
                child: ListTile(
                  title: TextFormField(
                    onChanged: (value){
                      _place = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none
                    ),
                    style: TextStyle(
                      decorationThickness: 0
                    ),
                  ),
                )
              ),
              const SizedBox(height: 16,),
              Text(
                '사진',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(height: 16,),
              DottedBorder(
                color: Colors.grey,
                dashPattern: [5,3],
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                child: Container(
                  width: 400,
                  height: 180,
                  decoration: _image!=null ? BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(_image!.path))
                      )
                  ) : null,
                  child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: (){
                                  getImage(ImageSource.camera);
                                },
                                icon: _image==null ? Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(
                                    CupertinoIcons.camera,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ) : Container(),
                              ),
                              _image==null ? Text(
                                '카메라',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary
                                ),
                              ) : Container()
                            ]
                        ),
                        SizedBox(width: 16),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              IconButton(
                                onPressed: (){
                                  getImage(ImageSource.gallery);
                                },
                                icon: _image==null ? Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(
                                    CupertinoIcons.arrow_up_doc,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ) : Container(),
                              ), _image==null ?
                              Text(
                                '갤러리',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary
                                ),
                              ) : Container()
                            ]
                        ),
                      ]
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.grey,
                      animationDuration: Duration(milliseconds: 1000),
                      primary: Colors.black,
                      shadowColor: Colors.black,
                      minimumSize: Size(350,50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: (){
                      final bytes = File(_image!.path).readAsBytesSync();
                      String base64Image =base64Encode(bytes);

                      RecordRegisterParams params = new RecordRegisterParams(
                        image: base64Image,
                        place: _place,
                        date: _day,
                        washList: newList
                      );

                      ref.read(recordRepositoryProvider).recordRegister(recordRegisterParams: params);

                    },
                    child: Text(
                      '완료',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if(pickedFile!=null){
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }
}

AppBar _renderAppbar(BuildContext context){
  return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back,size: 30),
          color: Colors.brown,
          alignment: Alignment.centerLeft,
        ),
      )
  );
}
