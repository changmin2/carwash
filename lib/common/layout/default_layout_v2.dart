import 'package:carwash/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultLayoutV2 extends ConsumerWidget {
  final Color? backgroundColor;
  final Widget child;
  final AppBar? appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget? bottomNavagtionBar;
  final Color? safeAreaColor;

  const DefaultLayoutV2({
    this.safeAreaColor = Colors.transparent,
    this.appBar,
    this.backgroundColor,
    required this.child,
    this.floatingActionButton,
    this.bottomNavagtionBar,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: child),
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavagtionBar,
    );
  }
}
