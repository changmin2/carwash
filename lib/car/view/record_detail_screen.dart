
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carwash/car/component/washlist_card.dart';
import 'package:carwash/car/provider/record_provider.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RecordDetail extends ConsumerStatefulWidget {
  static get routeName => 'recordDetailScreen';
  final int id;
  const RecordDetail({
    required this.id,
    Key? key}) : super(key: key);

  @override
  ConsumerState<RecordDetail> createState() => _RecordDetailState();
}

class _RecordDetailState extends ConsumerState<RecordDetail> {
  @override
  Widget build(BuildContext context) {
    final state = ref.read(RecordProvider('false')).firstWhere((element) => element.id == widget.id);
    var wash = state.washList.split("[")[1].split("]")[0].split(",");
    return DefaultLayoutV2(
      appBar: _renderAppbar(context),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
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
                      DateFormat('yyyy년 MM월 dd일 ').format(state.date)
                          +'('+ DateFormat('E','ko').format(state.date)+')',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),
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
                    title: Text(
                      state.place,
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
                    height: 250,
                    child :CachedNetworkImage(
                          imageUrl: state.imgUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                )
              ),
              const SizedBox(height: 16,),
              Text(
                '세차 순서',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(height: 16,),
              Wrap(
                direction: Axis.horizontal,
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.start,
                children:
                  List.generate(wash.length, (index) {
                    return WashListCard(step: index+1, wash: wash[index]);
                  }).toList()
                ),
              const SizedBox(height: 50)
            ],
          ),
        ),
      )
    );
  }
}

AppBar _renderAppbar(BuildContext context){
  return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        onPressed: (){Navigator.pop(context);},
        icon: Icon(Icons.arrow_back),
        color: Colors.brown,
        alignment: Alignment.centerLeft,
      )
  );
}