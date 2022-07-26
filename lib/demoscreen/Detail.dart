import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviwemap/demoscreen/HistoryMap.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    WebViewController? controller;
    String baseurl = "http://localhost:3000";
    int kmlIndex = 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: height / 2.5,
            child: WebView(
              initialUrl: '$baseurl/one/$kmlIndex/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                controller = webViewController;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Ship Name",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.red[900]),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("หมายเลขอุปกรณ์"),
                        Text("ทะเบียนเรือ"),
                        Text("เวลาที่ได้รับรายงาน"),
                        Text("เวลา จีพิเอส"),
                        Text("ตำแหน่ง(VMS)"),
                        Text("ละติจูด"),
                        Text("ลองติจูด"),
                        Text("สถานที่ใกล้เคียง"),
                        Text("ความเร็ว"),
                        Text("ทิศทาง"),
                        Text("แรงดันไฟฟ้า"),
                        Text("สัญญาณ GPS"),
                        Text("สัญญาณดาวเทียม"),
                        Text("วะนครับรอบกำหนดใช้บริการ"),
                        Text("วันหมดรับประกันอุปกรณ์"),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryMapScreen()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            color: Colors.red[700],
                            height: 50,
                            // width: 100,
                            child: Center(
                                child: Text("24 ตำแหน่งล่าสุด",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("หมายเลขอุปกรณ์"),
                        Text("ทะเบียนเรือ"),
                        Text("เวลาที่ได้รับรายงาน"),
                        Text("เวลา จีพิเอส"),
                        Text("ตำแหน่ง(VMS)"),
                        Text("ละติจูด"),
                        Text("ลองติจูด"),
                        Text("สถานที่ใกล้เคียง"),
                        Text("ความเร็ว"),
                        Text("ทิศทาง"),
                        Text("แรงดันไฟฟ้า"),
                        Text("สัญญาณ GPS"),
                        Text("สัญญาณดาวเทียม"),
                        Text("วะนครับรอบกำหนดใช้บริการ"),
                        Text("วันหมดรับประกันอุปกรณ์"),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          color: Colors.grey,
                          height: 50,
                          // width: 100,
                          child: Center(
                              child: Text("ประวัติการเดินเรือ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }
}
