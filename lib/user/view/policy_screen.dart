import 'package:carwash/common/layout/default_layout_v2.dart';
import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayoutV2(
      appBar: AppBar(
        title: Text('개인정보 처리방침'),
      ),
      child: Container(
        child: Text("ㅂ"),
      ),
    );
  }
}
