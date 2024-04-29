import 'package:carwash/car/model/accountBookDto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountBookProvider = StateNotifierProvider((ref) {
  return AccountBookNotifier();
});

class AccountBookNotifier extends StateNotifier<List<AccountBookDto>>{

  AccountBookNotifier() : super([]);

  List<AccountBookDto> get() {
    return state;
  }

  void add(AccountBookDto dto) {
    var pState = state as List<AccountBookDto>;
    state = [
      dto,
      ...pState
    ];
  }
}