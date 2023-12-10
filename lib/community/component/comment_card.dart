import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Card(
              child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                        child: Icon(
                          Icons.create,
                          color: Colors.brown,
                        )
                    ),
                    backgroundColor: Colors.white10,
                  ),
                  title: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                        'hi'
                    ),
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          child: Text(
                            '세린',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
              )
          ),
          //대댓글 자리
        ]
    );
  }
}
