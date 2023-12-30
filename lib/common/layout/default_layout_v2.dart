import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultLayoutV2 extends ConsumerWidget {
  final Color? backgroundColor;
  final Widget child;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavagtionBar;

  const DefaultLayoutV2({
    this.appBar =null,
    this.backgroundColor,
    required this.child,
    this.floatingActionButton=null,
    this.bottomNavagtionBar=null,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar==null ? null
        : appBar,
        body: SafeArea(child: child),
        // backgroundColor: backgroundColor ?? Colors.white,
        backgroundColor: backgroundColor,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavagtionBar,
      ),
    );
  }
}
