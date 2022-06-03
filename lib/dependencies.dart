import 'package:get/get.dart';
import 'package:news_app/bookmark_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => BookmarkController());
}
