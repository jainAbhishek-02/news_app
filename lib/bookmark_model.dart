import 'dart:convert';

class Bookmark {
  final String? title, url, urlToImage, source, content;

  Bookmark({this.title, this.url, this.urlToImage, this.source, this.content});

  factory Bookmark.fromJson(Map jsonData) {
    return Bookmark(
        source: jsonData["source"],
        title: jsonData["title"],
        url: jsonData["url"],
        urlToImage: jsonData["urlToImage"],
        content: jsonData["content"]);
  }

  static Map toMap(Bookmark bookmark) => {
        'source': bookmark.source,
        'url': bookmark.url,
        'title': bookmark.title,
        'urlToImage': bookmark.urlToImage,
        'content': bookmark.content,
      };

  static String encode(List bookmarks) =>
      json.encode(bookmarks.map((mark) => Bookmark.toMap(mark)).toList());

  static List decode(String mark) => (json.decode(mark) as List)
      .map((item) => Bookmark.fromJson(item))
      .toList();
}
