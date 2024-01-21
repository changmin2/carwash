import 'package:carwash/common/model/pagination_params.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/cursor_pagination_model.dart';
import '../model/model_with_idV2.dart';
import '../repository/comment_pagination_repository.dart';

class CommentPaginationProvider<T extends IModelWithIdV2,U extends IBasePaginationRepositoryV2<T>> extends StateNotifier<CursorPaginationBase>{
  final U repository;
  final int  id;

  CommentPaginationProvider({
    required this.repository,
    required this.id,
  }): super(CursorPaginationLoading()){
    paginate(
      id: id
    );
  }
  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
    required int id
  }) async{
    try{

      if(state is CursorPagination && !forceRefetch){
        final pState = state as CursorPagination;
        if(!pState.meta.hasMore){
          //더 데이터가 없다
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      //2번 상황, 로딩 중일 때 또 데이터를 요청하는걸 방지
      if(fetchMore && (isLoading || isRefetching || isFetchingMore)){
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );
      //fetchMore
      //데이터를 추가로 더 가져오는 상황
      if(fetchMore){
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore(
            data: pState.data,
            meta: pState.meta
        );
        paginationParams = paginationParams.copyWith(
            after: pState.data.last.id
        );
      }
      //데이터를 처음부터 가져오는 상황
      else{
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 Fetch (API 요청)를 진행
        if(state is CursorPagination && !forceRefetch){
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
              data: pState.data,
              meta: pState.meta
          );
        }
        //나머지 상황 데이터를 유지하지 않아도됨
        else{
          state = CursorPaginationLoading();
        }
      }
      final resp = await repository.commentPaginate(
          paginationParams: paginationParams, id: id
      );

      if(state is CursorPaginationFetchingMore){
        final pState = state as CursorPaginationFetchingMore<T>;

        //기존 데이터에 새로운 데이터 추가
        state = resp.copyWith(
            data: [
              ...pState.data,
              ...resp.data,
            ]
        );
      } else{
        state = resp;
      }
    }catch(e){
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }


}