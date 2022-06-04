import 'package:flutter/material.dart';
import 'package:news_app/bookmark_controller.dart';
import 'package:news_app/detail_screen.dart';
import 'bookmark_model.dart';

class NewsCard extends StatelessWidget {
  NewsCard({
    Key? key,
    required this.news,
    this.controller,
  }) : super(key: key);

  dynamic news;
  final BookmarkController? controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailScreen(
              news: news,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          // height: 300,
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: news["urlToImage"] != null
                    ? FadeInImage(
                        placeholder: const AssetImage(
                            'assets/images/placeholder_image.png'),
                        image: NetworkImage(news["urlToImage"]),
                        height: 130,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.asset(
                        'assets/images/placeholder_image.png',
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                // Image.network(
                //   news["urlToImage"],
                //   height: 160,
                //   width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            news["source"]["name"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            final Bookmark bookmark = Bookmark(
                              source: news["source"]["name"],
                              title: news["title"],
                              url: news["url"],
                              urlToImage: news["urlToImage"],
                              content: news["content"],
                            );
                            controller?.addBookmark(bookmark);
                          },
                          child: const Text('Add to Bookmark'),
                        ),
                      ],
                    ),
                    Text(
                      news["title"],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
