import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:carwash/naver/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchProductDetailScreen extends StatelessWidget {
  final Item item;
  const SearchProductDetailScreen({
    required this.item,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    child: Image.network(
                      item.image,
                      fit:BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        item.title.toString().replaceAll('<b>','').replaceAll('</b>', ''),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '브랜드명: '+item.brand,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                            ),

                          ),
                          Row(
                            children: [
                              Text(
                                '판매처: ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey
                                ),
                              ),
                              Text(
                                item.mallName,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey
                                ),
                              ),
                            ]
                          ),

                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '최저 '+item.lprice+'원',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                          '#' + item.category1+'#'+item.category2
                              +'#'+item.category3+'#'+item.category4
                      ),
                      SizedBox(
                        height: 50
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width*0.9,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                    onPressed: ()async{
                      var url = Uri.parse(item.link);
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      }
                    },
                    child: Text(
                        '최저가 보러가기>'
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(0)
                      )
                    ),

                ),
              ),
            )
          ]
        )
    );
  }
}
