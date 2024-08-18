import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NewsWebView extends StatefulWidget {
  String urlLink;
    NewsWebView({Key? key,required this.urlLink}) : super(key: key);

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
    WebViewController controller=WebViewController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Expanded(
          child: WebViewWidget(
              controller: controller
                ..loadRequest(Uri.parse('${widget.urlLink}')),

          ),
        ),
      ),
    );
  }
}
