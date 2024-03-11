import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imgUrl;

  const ImageViewerScreen({
    required this.imgUrl,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          width: MediaQuery.of(context).size.width*0.9,
          child: Image.network(
            imgUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
