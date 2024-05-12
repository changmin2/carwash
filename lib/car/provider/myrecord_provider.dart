import 'package:carwash/car/repository/record_repository.dart';
import 'package:carwash/user/provider/user_me_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final MyRecordProvider = StateNotifierProvider<MyRecordStateNotifier,List<String>>(
        (ref) {
      final repository = ref.watch(recordRepositoryProvider);
      ref.watch(userMeProvider);
      final notifier = MyRecordStateNotifier(repository: repository);

      return notifier;
    }
);

class MyRecordStateNotifier extends StateNotifier<List<String>>{
  final RecordRepository repository;

  MyRecordStateNotifier({
    required this.repository
  })
      :super(
      []
  ){
    getMyRecord();
  }


  Future<void> registerRecord(String washList) async {
    repository.registerMyRecord(washList: washList);
  }

  Future<void> getMyRecord() async {
    var result = await repository.getMyRecord();
    if(result != ""){
      state = result.split("[")[1].split("]")[0].split(",").toList();
    }
  }

  void change(List<String> selectList) {
    state = selectList ;
  }

}