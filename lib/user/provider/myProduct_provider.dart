import 'package:carwash/user/model/myProductDto.dart';
import 'package:carwash/user/repository/myProduct_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myProductProvider  = StateNotifierProvider<MyProductStateNotifier,List<MyProductDto>>((ref) {
  final repository = ref.watch(myProductRepositoryProvider);

  final notifier = MyProductStateNotifier(myProductRepository:repository);

  return notifier;
});

class MyProductStateNotifier extends StateNotifier<List<MyProductDto>>{
  final MyProductRepository myProductRepository;

  MyProductStateNotifier({
    required this.myProductRepository
  }):super(
      []
  );

  Future<void> addProduct(MyProductDto myProductDto) async {
    await myProductRepository.registerMyProduct(param: myProductDto);
    state.add(myProductDto);
  }


}