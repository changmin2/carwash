import 'package:carwash/car/repository/record_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final MyRecordProvider = StateNotifierProvider<MyRecordStateNotifier,List<String>>(
        (ref) {
      final repository = ref.watch(recordRepositoryProvider);

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
  );

  // Future<List<String>> getRecord()async {
  //
  // }

  Future<void> registerRecord(String washList) async {
    repository.registerMyRecord(washList: washList);
  }

}