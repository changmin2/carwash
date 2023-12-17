import 'package:flutter/cupertino.dart';
import '../provider/comment_pagination_provider.dart';
import '../provider/pagination_provider.dart';

class PaginationUtils{
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }){
    if(controller.offset > controller.position.maxScrollExtent - 300){
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}

class PaginationUtilsV2{
  static void paginate({
    required ScrollController controller,
    required CommentPaginationProvider provider,
    required int id,
  }){
    if(controller.offset > controller.position.maxScrollExtent - 300){
      provider.paginate(
          fetchMore: true, id: id
      );
    }
  }
}
