import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateLoginProvider  = ChangeNotifierProvider<StateChangeNotifier>((ref) {
  return StateChangeNotifier();
});

class StateChangeNotifier extends ChangeNotifier{
  bool flag = true;

  void change(){
    flag = flag ? false : true;
    notifyListeners();
  }
}