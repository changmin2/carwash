import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final SelectProvider  = ChangeNotifierProvider<SelectChangeNotifier>((ref) {
  return SelectChangeNotifier();
});

class SelectChangeNotifier extends ChangeNotifier{
  List<int> selects = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

  void select(int index){
    selects[index] == 0 ? selects[index]=1 : selects[index] = 0;
    notifyListeners();
  }

  void init(){
    selects = selects.map((e) => e==1 ? 0 : 0).toList();
  }

}