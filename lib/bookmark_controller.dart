import 'package:get/get.dart';
import 'package:news_app/bookmark_model.dart';
import 'package:news_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkController extends GetxController {
  var _bookmarkList = [];

  List get bookmarkList => _bookmarkList;

  @override
  void onInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String list = prefs.getString(bookmarkKey) ?? "";
    _bookmarkList = Bookmark.decode(list);
    if (_bookmarkList.isEmpty) {
      _bookmarkList.add(Bookmark(
        source: "News App",
        title: "All your bookmarks will appear here",
        url: "",
        urlToImage:
            "http://yelofy.in/psd_uploads/66e92dffb3651d87a5ef6eb8ea641d2b.jpg",
      ));

      // update();
    }

    super.onInit();
  }

  void addBookmark(Bookmark bookmark) {
    bool isExist = false;
    for (int i = 0; i < _bookmarkList.length; i++) {
      if (_bookmarkList[i].url == bookmark.url) {
        isExist = true;
        break;
      }
    }

    if (!isExist) {
      _bookmarkList.add(bookmark);
      print(bookmark.title);
      saveToPrefs();

      print(_bookmarkList.length);

      update();
    }
  }

  void removeBookmark(Bookmark bookmark) {
    final int index =
        _bookmarkList.indexWhere((element) => element.url == bookmark.url);
    _bookmarkList.removeAt(index);

    saveToPrefs();

    update();
  }

  void saveToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String encodedData = Bookmark.encode(_bookmarkList.toList());

    await prefs.clear();

    await prefs.setString(bookmarkKey, encodedData);
  }
}
