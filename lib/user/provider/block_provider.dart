import 'package:carwash/user/repository/block_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blockProvider  = StateNotifierProvider<BlockStateNotifier,List<String>>((ref) {
  final repository = ref.watch(blockRepositoryProvider);

  final notifier = BlockStateNotifier(blockRepository:repository);

  return notifier;
});

class BlockStateNotifier extends StateNotifier<List<String>>{
  final BlockRepository blockRepository;

  BlockStateNotifier({
    required this.blockRepository
  }):super(
      []
  );

  Future<List<String>?> getBlock() async{
    var pState = await blockRepository.getBlock();
    if(pState!=null){
      state = pState;
    }
  }

  Future<void> addBlock(String blockId) async {
    await blockRepository.addBlock(blockId: blockId);
  }


}