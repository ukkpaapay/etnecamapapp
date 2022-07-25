import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  List color = [
    Color.fromRGBO(71, 79, 88, 1.0),
    Color.fromRGBO(221, 106, 100, 1.0),
    Color.fromRGBO(222, 153, 134, 1.0),
    Color.fromRGBO(255, 191, 174, 1.0),
    Color.fromRGBO(218, 218, 218, 1.0),
    Color.fromRGBO(77, 164, 138, 1.0),
    Color.fromRGBO(243, 201, 71, 1.0)
  ];
  WebViewController? controller;
  List<String> kmlList = [
    'ไม่มี',
    'buffer05_final',
    'marine_NPRK_1984',
    'merge_เขตทะเลชายฝั่ง',
    'ปิดอ่าวตัวก',
    'เขตไหล่ทวีป-เขตเศรษฐกิจจำเพาะ',
    'เส้นไหล่ทวีป_NEW'
  ];
  String crkml = "ไม่มี";
  int kmlIndex = 0;
  String token = "AIzaSyDIMEOPBeQ-rHzg5kWLRhWyBPlpjrDSfz4";
  String baseurl = "http://localhost:3000";
  final script =
      "document.getElementById('value').innerText=\"{message.message}\"";

  @override
  Widget build(BuildContext context) {
    print(kmlIndex);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          WebView(
            initialUrl: '$baseurl/$token/$kmlIndex/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller = webViewController;
              webViewController.runJavascript('alert("I am an alert box!");');
            },
            javascriptChannels: {
              JavascriptChannel(
                  name: 'title',
                  onMessageReceived: (message) => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Location'),
                          content: Text("${message.message}"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      )),
              JavascriptChannel(
                  name: 'id',
                  onMessageReceived: (message) {
                    print("Message Form Web: ${message.message}");
                  }),
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Colors.white,
              ),
              // color: Colors.green,
              width: 250,
              height: 50,
              child: DropdownButton(
                  underline: SizedBox(),
                  isExpanded: true,
                  value: crkml,
                  items: kmlList.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      crkml = newValue!;
                      kmlIndex = kmlList.indexOf(newValue);
                    });
                    controller?.loadUrl('$baseurl/$token/$kmlIndex');
                  }),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_upward),
        onPressed: () {
          controller?.runJavascript('fromFlutter("From Flutter")');
        },
      ),
    );
    
  }
}
