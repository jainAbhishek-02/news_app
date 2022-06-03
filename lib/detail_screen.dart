import 'package:flutter/material.dart';
import 'package:news_app/webview_screen.dart';

class DetailScreen extends StatelessWidget {
  final dynamic news;
  const DetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          news["source"]["name"],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Image.network(
                  news["urlToImage"],
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        news["title"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        content(),
                        style: const TextStyle(
                          fontSize: 16,
                          wordSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => WebViewScreen(
                    url: news["url"],
                  ),
                ),
              );
            },
            child: const Text("Read full news"),
          ),
        ],
      ),
    );
  }

  String content() {
    if (news["content"] == null) {
      return "";
    }
    List content = news["content"].split(" [");
    return content[0];
  }
}
