import 'package:carousel_slider/carousel_slider.dart';
import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageViewerScreen extends StatefulWidget {
  final List<String> imgUrl;

  ImageViewerScreen({
    required this.imgUrl,
    Key? key}) : super(key: key);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height*0.85; // 화면의 높이
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: DefaultLayoutV2(
        appBar: AppBar(),
        child: Stack(
          children: [
            slider(
            widget.imgUrl
            , screenHeight),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: indicator(widget.imgUrl),
              ),
            )
          ],
        )
      ),
    );
  }

  //사진을 슬라이드하는 화면
  Widget slider(images, height) => CarouselSlider(
    items: List<Widget>.from(images.map((String item){
      return Image.network(item.trim(),fit: BoxFit.fill);
    }).toList()),
    options: CarouselOptions(
      aspectRatio: 16 / 9, // 화면 비율 default : 16/9
      height: height, // height 와 viewportFraction 을 기준으로 이미지의 크기가 설정됨.
      autoPlay: false,
      viewportFraction: 1, // 각 페이지가 차지하는 viewport의 정도임. 0.8로 설정하면 Indicator 가 없는 슬라이드 구성가능함.
      enlargeCenterPage: true, // 이미지보다 화면이 클 수 있는지 설정
      enableInfiniteScroll: false,
      initialPage: 0, // 초기 페이지 인덱스
      onPageChanged: (index, reason) => setState(() {
        activeIndex = index; // 페이지가 변경될 때, indicator 의 인덱스를 변경함.
      }),
    ),
  );

// Indicator
  Widget indicator(images) => Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.imgUrl.length,
        effect: JumpingDotEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.white,
            dotColor: Colors.white.withOpacity(0.6)),
      ));
}
