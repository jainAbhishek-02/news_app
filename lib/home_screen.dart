import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/bookmark_controller.dart';
import 'package:news_app/constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/news_card_widget.dart';
import 'package:news_app/search_screen.dart';
import 'api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic newItems;
  static const _pageSize = 20;

  final PagingController _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    print("hello");
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      newItems = await _getResponse(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<dynamic> _getResponse(int page) async {
    final response = await NetworkApi().getResponse(
        'top-headlines?country=in&pageSize=$_pageSize&page=$page&apiKey=$apiKey');

    // setState(() {
    //   _isFirstLoad = false;
    // });

    return response["articles"];
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BookmarkController>();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: const Text(
      //     'News App',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'User',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            PagedListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) {
                  return NewsCard(
                    news: item,
                    controller: controller,
                  );
                },
                firstPageProgressIndicatorBuilder: (_) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
                newPageProgressIndicatorBuilder: (_) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
