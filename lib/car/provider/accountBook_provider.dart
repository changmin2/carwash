import 'package:carwash/car/model/accountBookDto.dart';
import 'package:carwash/car/repository/accountBook_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountBookProvider = StateNotifierProvider((ref) {
  final repository = ref.read(accountBookRepositoryProvider);
  return AccountBookNotifier(
    accountBookRepository: repository
  );
});

class AccountBookNotifier extends StateNotifier<List<AccountBookDto>>{

  final AccountBookRepository accountBookRepository;

  AccountBookNotifier({
    required this.accountBookRepository
  }):super([]){
    get();
  }

  void get() async {
    final resp = await accountBookRepository.getAccountBooks();
    state = resp;
  }

  void add(AccountBookDto dto) async {
    final resp = await accountBookRepository.addAccountBook(
      param: dto
    );
    var pState = state as List<AccountBookDto>;
    state = [
      resp,
      ...pState
    ];
  }

  void delete(int id){
    accountBookRepository.deleteAccountBooks(id:id);

    final pState = state;
    List<AccountBookDto> tempList = [];

    //comment_id와 같은 항목은 삭제 했으므로 제외
    for(var i =0; i<pState.length;i++){
      if(pState[i].id != id){
        tempList.add(pState[i]);
      }

    }
    state = tempList;
  }

}