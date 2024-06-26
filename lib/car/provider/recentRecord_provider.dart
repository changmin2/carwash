import 'package:carwash/car/model/recordDto.dart';
import 'package:carwash/car/repository/record_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
    //처음 데이터가 아무것도 없을때 임시로 넣어둔 데이터삭제
    if(pState[0].date == '00'){
      state = [re];
    }
    else if(pState.length < 3){
      state = [
        re,
        ...pState
      ];
    }else{

      state = [
        re,
        ...pState
      ];

      //날짜 순 정렬 과거 날짜가 입력 될 수 있어서
      state.sort((a,b) => a.date.compareTo(b.date));

      //메인 화면엔 3개만 보여주므로 가장 과거날짜 제거
      state.removeAt(0);
      //내림차순 정렬
      state = List.from(state.reversed);

    }
  }

}