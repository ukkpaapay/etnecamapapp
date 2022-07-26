import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl: '$baseurl/$kmlIndex/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller = webViewController;
            },
            javascriptChannels: {
              JavascriptChannel(
                  name: 'title',
                  onMessageReceived: (message) => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            content: Builder(
                              builder: (context) {
                                return Container(
                                  height: 350,
                                  width: 300,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${message.message}",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.red[900]),
                                            ),
                                            Container(
                                              alignment:
                                                  FractionalOffset.topRight,
                                              child: GestureDetector(
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 30,
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("หมายเลขอุปกรณ์"),
                                                Text("ละติจูด"),
                                                Text("ลองติจูด"),
                                                Text("ความเร็ว"),
                                                Text("ทิศทาง"),
                                                Text("เวลาที่ได้รับรายงาน"),
                                                Text("เวลา จีพิเอส"),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("หมายเลขอุปกรณ์"),
                                                Text("ละติจูด"),
                                                Text("ลองติจูด"),
                                                Text("ความเร็ว"),
                                                Text("ทิศทาง"),
                                                Text("เวลาที่ได้รับรายงาน"),
                                                Text("เวลา จีพิเอส"),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          color: Colors.red[700],
                                          height: 50,
                                          width: 280,
                                          child: Center(
                                              child: Text("แสดงข้อมูลเพิ่มเติม",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white))),
                                        )
                                      ]),
                                );
                              },
                            ),
                          ))),
              JavascriptChannel(
                  name: 'shipdata',
                  onMessageReceived: (message) {
                    print(message.message);
                  }),
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 50,
                    margin: EdgeInsets.only(top: 40),
                    child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                          size: 45,
                          color: Colors.white,
                        ),
                        onPressed: () => null)),
                Container(
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
                        controller?.loadUrl('$baseurl/$kmlIndex');
                      }),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.centerRight,
              color: Colors.white,
              width: double.infinity,
              height: 75,
            ),
          )
        ],
      ),
    );
  }
}
