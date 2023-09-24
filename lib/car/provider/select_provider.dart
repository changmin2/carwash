import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final SelectProvider  = ChangeNotifierProvider<SelectChangeNotifier>((ref) {
  return SelectChangeNotifier();
});

// class SelectStateNotifier extends StateNotifier<List<int>>{
//   SelectStateNotifier()
//       : super(
//       [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
//   );
//
//   void select(int index){
//     state[index] == 0 ? state[index]=1 : state[index] = 0;
//   }
//
// }

class SelectChangeNotifier extends ChangeNotifier{
  List<int> selects = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

  void select(int index){
    selects[index] == 0 ? selects[index]=1 : selects[index] = 0;
    notifyListeners();
  }
}