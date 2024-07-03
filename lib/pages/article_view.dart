import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;

  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: RichText(
            text: TextSpan(
                text: "News",
                style: TextStyle(
                    color: Color.fromARGB(255, 249, 61, 61),
                    fontWeight: FontWeight.bold,
                    fontSize: 27),
                children: [
                  TextSpan(
                      text: "Pulse",
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 27))
                ]),
          ),
        ),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.blogUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
