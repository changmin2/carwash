import 'package:flutter/material.dart';

import '../../../component/event_card.dart';

class EventListWidget extends StatelessWidget {
  const EventListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: EventCard(
              index: index,
            ),
          );
        },
      ),
    );
  }
}
