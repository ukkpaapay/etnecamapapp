import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewcommu extends StatefulWidget {
  const Webviewcommu({Key? key}) : super(key: key);

  @override
  State<Webviewcommu> createState() => _WebviewcommuState();
}

class _WebviewcommuState extends State<Webviewcommu> {
  String baseurl = "http://localhost:3000";
  WebViewController? controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: '$baseurl',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            controller = webViewController;
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_upward),
          onPressed: () {
            controller?.runJavascript('fromFlutter("From Flutter")');
          },
        ),
      ),
    );
  }
}
