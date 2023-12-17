import 'package:carwash/common/model/pagination_params.dart';
import '../model/cursor_pagination_model.dart';
import '../model/model_with_idV2.dart';

abstract class IBasePaginationRepositoryV2<T extends IModelWithIdV2>{
  Future<CursorPagination<T>> commentPaginate({
    required int id,
    PaginationParams? paginationParams = const PaginationParams(),
  });
}