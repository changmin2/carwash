import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/car/repository/record_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/recentRecordDto.dart';



final recentRecordProvider = StateNotifierProvider.family<RecentRecordNotifier,List<recordDto>,String>((ref,memberId) {
  final repository = ref.watch(recordRepositoryProvider);
  return RecentRecordNotifier(repository,memberId);
});


class RecentRecordNotifier extends StateNotifier<List<recordDto>>{
  final RecordRepository repository;
  final String memberId;
  RecentRecordNotifier(this.repository,this.memberId) : super(
    []
  ){
    get(memberId);
  }


  void get(String memberId) async {
    RecentRecordDto recentDto = new RecentRecordDto(memberId: memberId);
    final recentRecord = await repository.recentRecord(param: recentDto);

    if(recentRecord.length>0){
      state = recentRecord;
    }else{
      recordDto re = new recordDto(id: 00, memberId: '00', imgUrl: '00', washList: '00', place: '00', date: DateTime.now());
      state = [re];
    }
  }

  void add(recordDto re) {
    var pState = state as List<recordDto>;
    if(pState.length < 3){
      state = [
        re,
        ...pState
      ];
    }else{
      pState.removeAt(0);
      state = [
        re,
        ...pState
      ];
    }
  }

}