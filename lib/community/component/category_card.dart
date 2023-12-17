import 'package:flutter/material.dart';

class CatergoryCard extends StatelessWidget {
  final category;
  const CatergoryCard({
    required this.category,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      child: Card(
        color: category == '자유게시판' ?Colors.red
        : category == '세차라이프' ? Colors.blue
        : Colors.grey,
        child: Center(
          child: Text(
            category,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
