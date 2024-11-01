

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final buttonProvider  = ChangeNotifierProvider<StateChangeNotifier>((ref) {
  return StateChangeNotifier();
});

class StateChangeNotifier extends ChangeNotifier{
  bool disable = false;

  Future<void> change() async {

    disable = await disable ? false : true;

    notifyListeners();
  }

  void init(){

    disable = false;
  }
}