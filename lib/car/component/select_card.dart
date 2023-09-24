import 'package:carwash/car/provider/select_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCard extends ConsumerStatefulWidget {
  final int index;
  final int select;

  const SelectCard({
    required this.index,
    required this.select,
    Key? key
  }) : super(key: key);

  @override
  ConsumerState<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends ConsumerState<SelectCard> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(SelectProvider);
    return GestureDetector(
      onTap: (){
        ref.read(SelectProvider.notifier).select(widget.index);
      },
      child: Card(
        color: widget.select == 0 ? Colors.white : Colors.green,
        child: Text(
          'hi'
        ),
      ),
    );
  }
}
