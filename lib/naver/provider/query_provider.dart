import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final QueryProvider  = ChangeNotifierProvider<QueryChangeNotifier>((ref) {
  return QueryChangeNotifier();
});

class QueryChangeNotifier extends ChangeNotifier{
  String query = '';

  void updateText(String newText) {
    query = newText;
    notifyListeners();
  }
}