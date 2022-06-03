import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({required this.url});
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: const Text(
          //   'News App',
          //   style: TextStyle(color: Colors.black),
          // ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          actions: [
            PopupMenuButton(
              // child: IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.more_vert_rounded),
              //   color: Colors.black,
              // ),

              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.black,
              ),
              itemBuilder: (ctx) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text('Open in browser'),
                ),
              ],
              onSelected: (int selection) async {
                switch (selection) {
                  case 0:
                    final url = Uri.parse(widget.url);

                    await launch(
                      widget.url,
                      enableJavaScript: true,
                    );
                    // if (await canLaunchUrl(url)) {
                    //   print("url launching");
                    //   await launch(widget.url);
                    // }
                    break;
                  default:
                }
              },
            ),
          ],
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
