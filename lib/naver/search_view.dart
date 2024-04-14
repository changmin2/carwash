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
  var itemlist = [];
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
                var items = await ref.read(searchRepositoryProvider).searchProduct(item: query.query);
                itemlist = items.items;
                setState(() {

                });
              },
              icon: Icon(Icons.search_rounded))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
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
                  }))
        ],
      ),
    );
  }
}