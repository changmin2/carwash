// screens/screen_search.dart
import 'package:carwash/naver/provider/query_provider.dart';
import 'package:carwash/naver/repository/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/search_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  int now = 0;
  var itemlist = [];
  var totalCount = 0;
  int _page = 1;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController()..addListener(_nextLoad);
  }

  void _nextLoad() async {
    if (_hasNextPage && !_isFirstLoadRunning && !_isLoadMoreRunning &&
        _controller.position.extentAfter < 10) {

      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;

      try {
        var res = await ref.read(searchRepositoryProvider).searchProduct(item: ref.read(QueryProvider).query,start: now+1);
        if (res.items.isNotEmpty) {
          setState(() {
            now+=res.items.length;
            itemlist.addAll(res.items);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (e) {
        print(e.toString());
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // 스크롤 위치를 맨위로 이동시킵니다.
  void _scrollToTop() {
    setState(() {
      _controller.jumpTo(0);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_nextLoad);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.read(QueryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            TextField(
              onChanged: (text) {
                query.updateText(text);
              },
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'search keyword',
                border: InputBorder.none,
              ),
              cursorColor: Colors.grey,
            )
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () async {
                totalCount = 0;
                itemlist = [];
                now = 0;
                var items = await ref.read(searchRepositoryProvider).searchProduct(item: query.query);
                totalCount = items.total;
                itemlist = items.items;
                now+=itemlist.length;
                setState(() {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _scrollToTop();
                });
              },
              icon: Icon(Icons.search_rounded))
        ],
      ),
      body: itemlist.length == 0
      ?
          Container()
      :
      Column(
        children: [
          const SizedBox(height: 8),
          Text(
            '총 $totalCount 건',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
              child: GridView.builder(
                  controller: _controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                  ),
                  itemCount: itemlist.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Image.network(itemlist[index].image),
                                  height: 200,
                                ),
                                Text(
                                  itemlist[index].title.toString().replaceAll('<b>','')
                                      .replaceAll('</b>', ''),
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  itemlist[index].lprice.toString() + '원',
                                  style: TextStyle(fontSize: 16, color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        ));
                  }
              )
          ),
        ],
      ),
    );
  }
}