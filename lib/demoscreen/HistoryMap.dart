import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Detail.dart';

class HistoryMapScreen extends StatefulWidget {
  @override
  State<HistoryMapScreen> createState() => _HistoryMapScreenState();
}

class _HistoryMapScreenState extends State<HistoryMapScreen> {
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
            initialUrl: '$baseurl/track/$kmlIndex/',
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
                                  height: 250,
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
                                              "ทใพรวิษณุ",
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
                          Icons.arrow_back_ios,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context))),
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
                        controller?.loadUrl('$baseurl/Track/$kmlIndex');
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
