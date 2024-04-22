// screens/screen_search.dart
import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:carwash/naver/provider/query_provider.dart';
import 'package:carwash/naver/repository/search_repository.dart';
import 'package:carwash/naver/view/search_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/helpers/helper_functions.dart';
import '../model/search_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
  bool _isFirstLoadRunning = true;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController()..addListener(_nextLoad);
  }

  void _nextLoad() async {
    if (_hasNextPage && !_isFirstLoadRunning && !_isLoadMoreRunning && _controller.position.extentAfter < 10) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;

      try {
        var res = await ref.read(searchRepositoryProvider).searchProduct(item: ref.read(QueryProvider).query, start: now + 1);
        if (res.items.isNotEmpty) {
          setState(() {
            now += res.items.length;
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
        backgroundColor: Colors.white,
        title: SearchBar(
          autoFocus: true,
          // backgroundColor: const MaterialStatePropertyAll(Color(0xffF8F8FA)),
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          leading: const Icon(Icons.search_rounded),
          elevation: const MaterialStatePropertyAll(0),
          side: MaterialStateProperty.all(
            const BorderSide(color: PRIMARY_COLOR),
          ),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 10)),
          constraints: const BoxConstraints(minHeight: 40),
          onSubmitted: (value) async {
            _isFirstLoadRunning = true;
            totalCount = 0;
            itemlist = [];
            now = 0;
            var items = await ref.read(searchRepositoryProvider).searchProduct(item: value);
            totalCount = items.total;
            itemlist = items.items;
            now += itemlist.length;
            setState(() {
              _hasNextPage = true;
              _isFirstLoadRunning = false;
              FocusManager.instance.primaryFocus?.unfocus();
              //_scrollToTop();
            });
          },
        ),
      ),

      body: itemlist.isEmpty
          ? const Center(child: Text('검색 결과가 없습니다.\n다른 검색어로 다시 검색해 보세요!'))
          : _isFirstLoadRunning
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    // const SizedBox(height: 8),
                    // Text(
                    //   '총 $totalCount 건',
                    //   style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
                    // ),
                    // const SizedBox(height: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                                controller: _controller,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1.5,
                                ),
                                itemCount: itemlist.length,
                                itemBuilder: (context, index) {
                                  return GridTile(
                                    child: InkWell(
                                      onTap: () {
                                        THelperFunctions.navigateToScreen(
                                          context,
                                          SearchProductDetailScreen(
                                            item: itemlist[index],
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              child: Image.network(itemlist[index].image),
                                            ),
                                            Text(
                                              itemlist[index].title.toString().replaceAll('<b>', '').replaceAll('</b>', ''),
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${itemlist[index].lprice}원',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          if (_isLoadMoreRunning == true)
                            Container(
                              padding: const EdgeInsets.all(30),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          if (_hasNextPage == false)
                            Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.blue,
                              child: const Center(
                                child: Text('No more data to be fetched.', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
