import 'package:flutter/material.dart';
import 'package:news_app/api_provider.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/news_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  List news = [];
  bool _isLoading = false;

  void _searchNews(String searchQuery) async {
    setState(() {
      _isLoading = true;
    });
    final response = await NetworkApi().getResponse(
        "everything?q=$searchQuery&pageSize=10&from=2022-06-03&sortBy=popularity&apiKey=$apiKey");

    news = response["articles"];

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 13),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              hintText: 'search here ...',
              hintStyle: TextStyle(color: Colors.grey.shade400),
            ),
            onChanged: (value) {
              if (value.length > 3) {
                _searchNews(value);
              }
            },
          ),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: news.length,
                itemBuilder: (ctx, index) {
                  return NewsCard(news: news[index]);
                }),
      ),
    );
  }
}
