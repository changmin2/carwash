import 'package:carwash/car/provider/state_provider.dart';
import 'package:carwash/car/repository/record_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/recordDto.dart';

final
RecordProvider = StateNotifierProvider.family<RecordStateNotifier,List<recordDto>,String>(
        (ref,flag) {
      final repository = ref.watch(recordRepositoryProvider);

      final notifier = RecordStateNotifier(repository: repository,flag: flag);

      return notifier;
    }
);

class RecordStateNotifier extends StateNotifier<List<recordDto>>{
  final RecordRepository repository;
  final String flag;
  RecordStateNotifier({
    required this.repository,
    required this.flag
  })
  :super(
    []
  );

  Future<List<recordDto>> getRecord(
      bool? stateflag
      )async {
    if(state.length!=0 && flag=='false' && stateflag==false){

    }else{

      var pstate = await repository.getRecord(date: "hi");
      state = pstate;
    }
    return state;
  }

}