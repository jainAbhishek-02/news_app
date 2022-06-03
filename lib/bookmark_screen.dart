import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/bookmark_controller.dart';
import 'package:news_app/bookmark_model.dart';
import 'package:news_app/detail_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bookmarks',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GetBuilder<BookmarkController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.bookmarkList.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                onTap: () {
                  dynamic news = {
                    "source": {
                      "name": controller.bookmarkList[index].source ?? ""
                    },
                    "urlToImage":
                        controller.bookmarkList[index].urlToImage ?? "",
                    "title": controller.bookmarkList[index].title ?? "",
                    "url": controller.bookmarkList[index].url,
                    "content": controller.bookmarkList[index].content ?? "",
                  };

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(
                        news: news,
                      ),
                    ),
                  );
                },
                contentPadding: const EdgeInsets.all(12),
                leading: Image.network(
                  controller.bookmarkList[index].urlToImage ??
                      "assets/images/placeholder_image.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  controller.bookmarkList[index].title ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(controller.bookmarkList[index].source ?? ""),
                trailing: IconButton(
                  onPressed: () {
                    final bookmark = Bookmark(
                      source: controller.bookmarkList[index].source,
                      title: controller.bookmarkList[index].title,
                      url: controller.bookmarkList[index].url,
                      urlToImage: controller.bookmarkList[index].urlToImage,
                    );
                    controller.removeBookmark(bookmark);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
